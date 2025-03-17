set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -g fish_greeting # disable fish greeting
set -g fish_prompt_pwd_dir_length 0
set -g fish_key_bindings fish_vi_key_bindings

set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

for line in (cat ~/.env | grep -v "^#")
    set item (string split -m 1 "=" $line)
    set -gx $item[1] $item[2]
    set -e item
end

fish_add_path -gP $DOTFILES_REPO_DIR/bin

set -gx SNC_PROVISION_DEV_RSYNC true
set -gx SNC_PROVISION_QEMU_MEM 16G
set -gx SNC_PROVISION_QEMU_SMP 8
