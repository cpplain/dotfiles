export CLICOLOR=1

alias l1="ls -a1"
alias ll="ls -al"
alias python="python3"

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

if which go > /dev/null; then
    export GOPATH="$(go env GOPATH)"
    export PATH="$GOPATH:$GOPATH/bin:$PATH"
fi

if which nodenv > /dev/null; then
    eval "$(nodenv init -)"
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

eval "$(starship init zsh)"
