#!/usr/bin/env python3
"""公開可能な表示・操作設定だけを保存/復元する。認証やセキュリティ設定は扱わない。"""
import argparse
import datetime
import json
from pathlib import Path
import plistlib
import subprocess

KEYS = {
    'NSGlobalDomain': ['AppleInterfaceStyle', 'AppleShowAllExtensions', 'KeyRepeat',
                      'InitialKeyRepeat', 'ApplePressAndHoldEnabled',
                      'NSAutomaticCapitalizationEnabled', 'NSAutomaticSpellingCorrectionEnabled'],
    'com.apple.dock': ['autohide', 'tilesize', 'orientation', 'magnification', 'largesize', 'mineffect'],
    'com.apple.finder': ['ShowPathbar', 'ShowStatusBar', 'FXPreferredViewStyle', 'AppleShowAllFiles'],
}
REPO = Path(__file__).resolve().parents[1]
FILE = REPO / 'manifests/macos-preferences.json'

def capture():
    result = {}
    for domain, keys in KEYS.items():
        process = subprocess.run(['defaults', 'export', domain, '-'], capture_output=True)
        if process.returncode:
            raise RuntimeError('設定を読み取れませんでした: ' + domain)
        values = plistlib.loads(process.stdout)
        # 一覧にあるキー以外の情報は保存も表示もしない。
        result[domain] = {key: values.get(key) for key in keys}
    return result

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--capture', action='store_true')
    group.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    if args.capture:
        FILE.write_text(json.dumps(capture(), ensure_ascii=False, indent=2) + '\n')
        print('保存:', FILE)
        return
    data = json.loads(FILE.read_text())
    commands = []
    for domain, values in data.items():
        if domain not in KEYS:
            raise ValueError('対象外ドメイン: ' + domain)
        for key, value in values.items():
            if key not in KEYS[domain]:
                raise ValueError('対象外キー: ' + key)
            if value is None:
                cmd = ['defaults', 'delete', domain, key]
            else:
                kind = {bool: '-bool', int: '-int', float: '-float', str: '-string'}.get(type(value))
                if kind is None:
                    raise ValueError('未対応の型: ' + key)
                literal = ('true' if value else 'false') if type(value) is bool else str(value)
                cmd = ['defaults', 'write', domain, key, kind, literal]
            commands.append(cmd)
    if args.apply:
        backup = Path.home() / '.local/state/dotfiles-backups' / ('macos-' + datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f') + '.json')
        backup.parent.mkdir(parents=True, exist_ok=True)
        backup.write_text(json.dumps(capture(), ensure_ascii=False, indent=2) + '\n')
        print('変更前の保存先:', backup)
    for cmd in commands:
        print(' '.join(cmd))
        if args.apply:
            process = subprocess.run(cmd, capture_output=True, text=True)
            if process.returncode and cmd[1] != 'delete':
                raise RuntimeError(process.stderr)
    print('反映にはログアウト・再ログインが必要な場合があります。' if args.apply else '確認のみ。反映は --apply を指定してください。')

if __name__ == '__main__':
    main()
