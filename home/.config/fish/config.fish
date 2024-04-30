set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_CACHE_HOME ~/.cache

set -gx HOMEBREW_BUNDLE_NO_LOCK 1

set brew_path /opt/homebrew/bin
if test (uname -m) = x86_64
    set brew_path /usr/local/bin
end
$brew_path/brew shellenv | source
set -e brew_path

set -gx GOPATH (go env GOPATH)
fish_add_path $GOPATH/bin

kubectl completion fish | source
nodenv init - | source
pyenv init - | source
rbenv init - | source

set -g fish_greeting # disable fish greeting
set -g fish_key_bindings fish_vi_key_bindings

set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

starship init fish | source
# enable_transience
