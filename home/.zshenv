export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR=$HOME/.config/zsh

export HOMEBREW_BUNDLE_NO_LOCK=1

brew=/opt/homebrew/bin/brew
if test $(uname -m) = "x86_64"; then
    brew=/usr/local/bin/brew
fi

eval "$($brew shellenv)"

export GOPATH="$(go env GOPATH)"
export PATH="$GOPATH/bin:$PATH"

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

if [ -f ~/.zshenv_servicenow ]; then
    source ~/.zshenv_servicenow
fi
