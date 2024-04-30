export CLICOLOR=1

alias l1="ls -a1"
alias ll="ls -al"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export HOMEBREW_BUNDLE_NO_LOCK=1

brew_path=/opt/homebrew/bin
if test $(uname -m) = "x86_64"; then
    brew_path=/usr/local/bin
fi
eval "$($brew_path/brew shellenv)"

export GOPATH="$(go env GOPATH)"
export PATH="$GOPATH/bin:$PATH"

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

eval "$(starship init zsh)"
