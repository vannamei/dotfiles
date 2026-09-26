#!/usr/bin/env python3
"""別ファイルとして保存される設定をリポジトリに取り込む。送信・コミットはしない。"""
from pathlib import Path
import shutil
repo = Path(__file__).resolve().parents[1]
# 列挙した設定だけを取り込み、認証ファイルや履歴を探索しない。
files = [
    '.config/karabiner/karabiner.json',
    '.config/mise/config.toml',
]
for rel in files:
    source = Path.home() / rel
    target = repo / rel
    if not source.is_file():
        print('未検出:', rel)
        continue
    if source.resolve() == target.resolve():
        print('リンク管理済み:', rel)
        continue
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, target)
    print('保存:', rel)
print('git diff で確認してから commit / push してください。')
