# completion
autoload -U compinit && compinit -u

# alias
## system
alias ..='cd ..'
alias ...='cd ../..'
alias ..2='cd ../..'
alias ....='cd ../../..'
alias ..3='cd ../../..'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias edit='nvim'
alias his='history'
alias l='ls'
alias la='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias open='live-server'

## global
alias -g @g='| grep --color=auto'
alias -g @l='| less -R'

## suffix
alias -s gz='tar -xzvf'
alias -s html='open'

## exa
if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l='exa --icons --git'
  alias ea='exa -a --icons --git'
  alias la='exa -a --icons --git'
  alias ee='exa -aahl --icons --git'
  alias ll='exa -aahl --icons --git'
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons'
fi

## bat
if [[ $(command -v bat) ]]; then
  alias b='bat'
fi

## git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias ga='git add'
alias gb='git branch'
alias gsw='git switch'
alias gswm='git switch main'
alias gr='git restore'
alias grs='git restore --staged'
alias gc='git commit'
alias gcm='git commit -m'
alias gg='git grep'
alias gf='git fetch'
alias gm='git merge'
alias gpo='git push origin'
alias gpom='git push origin main'
alias gst='git stash'
alias gstl='git stash list'
alias gstu='git stash -u'
alias gstp='git stash pop'

## Docker
if [[ $(command docker -v) ]]; then
  alias d='docker'
  alias di='docker images'
  alias drmi='docker rmi'
  alias dp="docker ps"
  alias dpa="docker ps -a"
  alias dr="docker rm"
  alias dra="docker rm `docker ps -a -q`"
fi
if [[ $(command docker-compose -v) ]]; then
  alias dcb='docker compose build'
  alias dcu='docker compose up -d'
  alias dcd='docker compose down'
  alias dcde='docker compose down --rmi all --volumes --remove-orphans'
  alias dcr='docker compose restart'
  alias dce='docker compose exec'
fi

## Rust
if [[ $(command -V cargo) ]]; then
### cargo
  alias c='cargo'
  alias cc='cargo check'
  alias cb='cargo build'
  alias cr='cargo run'
fi

## Laravel Sail
alias sail="./vendor/bin/sail"

# color
autoload -Uz colors
colors

# japanese
setopt print_eight_bit

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

# beep
setopt no_beep
setopt nolistbeep

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space

# asdf
. /opt/asdf-vm/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# genie(systemd)
if [[ ! -v INSIDE_GENIE ]]; then
 exec /usr/bin/genie -s
fi

# use starship for prompt
if [[ $(command -v starship) ]]; then
  eval source <($(command which starship) init zsh --print-full-init)
fi
