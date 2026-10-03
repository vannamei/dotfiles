#!/usr/bin/env python3
"""実設定の保存漏れを検出・取り込む。認証情報の探索やGitへの送信はしない。"""
import argparse
import datetime
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

FILES = ('.config/karabiner/karabiner.json', '.config/mise/config.toml')

def snapshot(repo, home, check=False):
    pending = []
    missing = []
    for rel in FILES:
        source, target = home / rel, repo / rel
        if not source.is_file():
            missing.append(rel)
            print('実設定がありません:', rel)
            continue
        data = source.read_bytes()
        if rel.endswith('.json'):
            json.loads(data)
        else:
            try:
                import tomllib
            except ImportError as exc:
                raise RuntimeError('Python 3.11以上が必要です。./scripts/save.sh でmiseのPythonを使用してください。') from exc
            tomllib.loads(data.decode())
        if target.is_file() and target.read_bytes() == data:
            print('一致:', rel)
        else:
            pending.append((rel, source, target))
            print('未取り込み:', rel)
    if check:
        return 1 if pending or missing else 0
    if missing:
        raise RuntimeError('実設定が不足しているため、取り込みは行いません。')
    # Git側も編集されていれば、無条件に上書きしない。全ファイルを先に検証する。
    for rel, _, _ in pending:
        status = subprocess.run(['git', '-C', str(repo), 'status', '--porcelain', '--', rel], capture_output=True, text=True, check=True)
        if status.stdout:
            raise RuntimeError('Git側にも変更があります。先に内容を統合してください: ' + rel)
    gitdir = subprocess.check_output(['git', '-C', str(repo), 'rev-parse', '--absolute-git-dir'], text=True).strip()
    backup = Path(gitdir) / 'dotfiles-snapshots' / datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f')
    for rel, source, target in pending:
        if target.exists():
            saved = backup / rel
            saved.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(target, saved)
        target.parent.mkdir(parents=True, exist_ok=True)
        # 中途半端な書き込みを避け、完成した内容に置き換える。
        fd, tmp = tempfile.mkstemp(prefix='.snapshot-', dir=target.parent)
        try:
            with os.fdopen(fd, 'wb') as stream:
                stream.write(source.read_bytes())
            os.replace(tmp, target)
        finally:
            if os.path.exists(tmp):
                os.unlink(tmp)
        print('取り込み完了:', rel)
    return 0

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='変更せず差分を検出。一致=0、不一致/欠損=1')
    args = parser.parse_args()
    try:
        raise SystemExit(snapshot(Path(__file__).resolve().parents[1], Path.home(), args.check))
    except (RuntimeError, ValueError, OSError, subprocess.CalledProcessError) as exc:
        parser.exit(2, str(exc) + '\n')
