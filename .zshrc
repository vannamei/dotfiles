# 対話シェル専用。スクリプト実行時には補完やプロンプトを初期化しない。
[[ -o interactive ]] || return

# ログインシェルを経由しないターミナルでも Homebrew を利用できるようにする。
if [[ -z ${HOMEBREW_PREFIX:-} && -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# 同じ PATH の追加を繰り返しても重複させない。
typeset -U path PATH
for _terminal_dir in "$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin"; do
  [[ -d $_terminal_dir ]] && path=("$_terminal_dir" $path)
done
# 以前の構成から引き継がれた、確認済みの不要な参照だけを除く。
for _terminal_dir in "$HOME/bin" /opt/pmk/env/global/bin; do
  [[ -d $_terminal_dir ]] || path=("${(@)path:#$_terminal_dir}")
done
unset _terminal_dir

# 既存の日本語環境を維持。明示された LANG は上書きしない。
export LANG=${LANG:-ja_JP.UTF-8}
if (( $+commands[nvim] )); then
  export EDITOR=nvim
  export VISUAL=nvim
fi

# Ctrl-s / Ctrl-q を端末の停止・再開に使わず、エディターへ渡す。
unsetopt FLOW_CONTROL
if [[ -t 0 ]]; then
  stty -ixon 2>/dev/null || true
fi

# 履歴を複数のターミナルで共有する。
# SHARE_HISTORY が追記も担当するため INC_APPEND_HISTORY は併用しない。
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=40000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_EXPIRE_DUPS_FIRST HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE  # 先頭に空白を入れたコマンドは履歴に保存しない。
setopt AUTO_CD           # ディレクトリ名だけで移動する。

# Homebrew の補完パスが設定された後に初期化する。
# 通常の compinit の安全性チェックを維持し、既存のダンプキャッシュを利用する。
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# インストール済みの場合だけ便利な別名を定義する。
if (( $+commands[eza] )); then
  alias ls='eza -lhF'
  alias la='eza -lahF'
fi
(( $+commands[nvim] )) && alias v='nvim'

# 既存の Perl ローカルライブラリを維持する。再読み込み時の重複を防ぐ。
if [[ -d "$HOME/perl5" ]]; then
  [[ -d "$HOME/perl5/bin" ]] && path=("$HOME/perl5/bin" $path)
  typeset -gxUT PERL5LIB perl5lib
  perl5lib=("$HOME/perl5/lib/perl5" $perl5lib)
  typeset -gxUT PERL_LOCAL_LIB_ROOT perl_local_lib_root
  perl_local_lib_root=("$HOME/perl5" $perl_local_lib_root)
  export PERL_MB_OPT="--install_base \"$HOME/perl5\""
  export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
fi

# Antigravity のコマンドが実在する環境だけ PATH に追加する。
[[ -d "$HOME/.antigravity/antigravity/bin" ]] && path=("$HOME/.antigravity/antigravity/bin" $path)

# mise がプロジェクトごとの開発言語を切り替える。
# activate と手動の shims 追加を二重に設定しない。
if (( $+commands[mise] )); then
  path=("${(@)path:#$HOME/.local/share/mise/shims}")
  eval "$(mise activate zsh)"
fi

# プロンプトは最後に初期化する。キャッシュ保存先は初期化より先に指定する。
export STARSHIP_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/starship"
if [[ ${TERM:-dumb} != dumb ]] && (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
