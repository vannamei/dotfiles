# ログインシェル: Homebrew の実行ファイル・manページなどを設定する。
# GUI 全体の PATH は変更せず、このシェルと子プロセスにだけ引き継ぐ。
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# zsh の path 配列と PATH を同期し、同じディレクトリの重複を取り除く。
typeset -U path PATH
