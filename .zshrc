export LANG=ja_JP.UTF-8
export EDITOR=nvim

export PATH="$HOME/bin:$PATH"

HISTSIZE=10000 #メモリ上限
SAVEHIST=10000 #ファイル上限
HISTFILE=~/.zsh_history
setopt inc_append_history share_history
setopt hist_ignore_dups hist_reduce_blanks

setopt auto_cd #ディレクトリ名だけでcd

# 補完
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# エイリアス
alias ls='eza -lahF'
alias v='nvim'

# tmux
if [ -z "$TMUX" ]; then
  exec tmux
fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# starship
eval "$(starship init zsh)"
export STARSHIP_CACHE=$HOME/.cache/starship

# mise
eval "$(mise activate zsh)"
export PATH="$HOME/.local/share/mise/shims:$PATH"

PATH="/Users/vannamei/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/vannamei/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/vannamei/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/vannamei/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/vannamei/perl5"; export PERL_MM_OPT;
