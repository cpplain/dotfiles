set -g fish_greeting # disable fish greeting

set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_CACHE_HOME ~/.cache

set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

set -g fish_key_bindings fish_vi_key_bindings

set -gx GOPATH (go env GOPATH)
fish_add_path $GOPATH $GOPATH/bin

brew shellenv | source
nodenv init - | source
pyenv init - | source
rbenv init - | source

starship init fish | source
enable_transience
