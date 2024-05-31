set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_CACHE_HOME ~/.cache

set -gx HOMEBREW_BUNDLE_NO_LOCK 1

set brew /opt/homebrew/bin/brew
if test (uname -m) = x86_64
    set brew /usr/local/bin/brew
end
$brew shellenv | source
set -e brew

if type -fq go
    set -gx GOPATH (go env GOPATH)
    fish_add_path $GOPATH/bin
end

type -fq kubectl && kubectl completion fish | source
type -fq nodenv && nodenv init - | source
type -fq pyenv && pyenv init - | source
type -fq rbenv && rbenv init - | source

if test -e ~/.config/fish/config_work.fish
    source ~/.config/fish/config_work.fish
end

set -g fish_greeting # disable fish greeting
set -g fish_key_bindings fish_vi_key_bindings

set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

starship init fish | source
