#!/bin/bash
# 設定の取り込みと確認をまとめる。commit/pushは差分確認後に本人が実行する。
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd -P)"
# macOS標準Pythonが古い場合も、mise管理のPythonでTOMLを検証する。
python_runner=(python3)
if command -v mise >/dev/null; then
  python_runner=(mise exec python -- python3)
fi
case "${1:-}" in
  '') "${python_runner[@]}" "$repo_dir/scripts/snapshot.py" ;;
  --check) exec "${python_runner[@]}" "$repo_dir/scripts/snapshot.py" --check ;;
  *) echo '使い方: ./scripts/save.sh [--check]' >&2; exit 2 ;;
esac
git -C "$repo_dir" status --short
git -C "$repo_dir" diff --stat
echo '取り込み済みです。git diff と git diff --cached を確認してから commit / push してください。'
