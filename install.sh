#!/bin/bash
# macOS 標準の Bash 3.2 で動作する。引数なしでは変更予定だけを表示する。
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")" && pwd -P)"
target_home="${DOTFILES_TARGET_HOME:-$HOME}"
apply=false
install_tools=false
for arg in "$@"; do
  case "$arg" in
    --apply) apply=true ;;
    --tools) install_tools=true ;;
    --help) echo '使い方: ./install.sh [--apply] [--tools]'; exit 0 ;;
    *) echo "不明な引数: $arg" >&2; exit 2 ;;
  esac
done
# 先に全ソースの存在を確認し、途中まで適用されるのを防ぐ。
while IFS= read -r rel; do
  [[ -z "$rel" || "$rel" == \#* ]] && continue
  [[ -e "$repo_dir/$rel" ]] || { echo "設定がありません: $rel" >&2; exit 1; }
done < "$repo_dir/manifests/links.txt"
backup_dir="$target_home/.local/state/dotfiles-backups/$(date +%Y%m%d-%H%M%S)-$$"
while IFS= read -r rel; do
  [[ -z "$rel" || "$rel" == \#* ]] && continue
  src="$repo_dir/$rel"
  dst="$target_home/$rel"
  if [[ -e "$dst" && "$src" -ef "$dst" ]]; then
    echo "設定済み: $rel"
    continue
  fi
  echo "適用予定: $rel -> $src"
  if $apply; then
    # ファイル・ディレクトリ・切れたリンクをすべて退避してから配置する。
    if [[ -e "$dst" || -L "$dst" ]]; then
      mkdir -p "$backup_dir/$(dirname "$rel")"
      mv "$dst" "$backup_dir/$rel"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
  fi
done < "$repo_dir/manifests/links.txt"
if $install_tools; then
  if $apply; then
    command -v brew >/dev/null || { echo '先に https://brew.sh/ からHomebrewを導入してください。' >&2; exit 1; }
    # 既存パッケージの一括更新や、未記載パッケージの削除は行わない。
    brew bundle install --no-upgrade --file="$repo_dir/Brewfile"
    eval "$(brew shellenv)"
    mise install
  else
    echo 'ツール導入予定: Brewfile と mise の固定バージョン（--apply 指定時のみ実行）'
  fi
fi
if $apply; then
  echo "適用完了。退避があれば: $backup_dir"
  echo '新しいターミナルを開いてください。Neovimの初回取得中は終了せず、:Lazy / :Masonで完了を確認してください。'
else
  echo '変更は行っていません。適用するには --apply を指定してください。'
fi
