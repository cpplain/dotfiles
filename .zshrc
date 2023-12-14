export CLICOLOR=1

alias l1="ls -a1"
alias ll="ls -al"
alias python="python3"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Go
if test $(which go); then
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
fi

# nodenv
if test $(which nodenv); then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
fi

# pyenv
if test $(which pyenv); then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"
fi

# rbenv
if test $(which rbenv); then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

eval "$(starship init zsh)"
