export LANG=ja_JP.UTF-8

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

if [ -d "$HOME/bin" ]; then
  export PATH=$HOME/bin:$PATH
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH=$HOME/.local/bin:$PATH
fi

# Neovim
export ZENHAN='/mnt/c/Scoop/apps/zenhan/current/zenhan.exe'

# fnm(Node.js)
  export PATH=$HOME/.fnm:$PATH
  eval "$(fnm env --use-on-cd)"

# Rust
if [ -d "$HOME/.rustup" ]; then
  export PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/:$PATH
fi
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi
. "$HOME/.cargo/env"

# Composer
export PATH=$XDG_CONFIG_HOME/composer/vendor/bin:$PATH
