set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_RUNTIME_DIR $TMPDIR

set -gx EDITOR nvim

set -gx SNC_PROVISION_DEV_RSYNC true
set -gx SNC_PROVISION_QEMU_MEM 16G
set -gx SNC_PROVISION_QEMU_SMP 8

for line in (cat ~/.env | grep -v "^#")
    set item (string split -m 1 "=" $line)
    set -gx $item[1] $item[2]
    set -e item
end

fish_add_path -gP $CONFIG_REPO/bin

set -g fish_greeting # disable fish greeting
set -g fish_prompt_pwd_dir_length 0
set -g fish_key_bindings fish_vi_key_bindings

set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

#
# Abbreviations
#

# Config Manager
abbr cmbc "cfgmanager --bundle-cleanup"
abbr cmbb "cfgmanager --brew-bundle"
abbr cmcl "cfgmanager --create-links"
abbr cmpl "cfgmanager --prune-links"

# Git
abbr g git
abbr ga "git add"
abbr gb "git branch"
abbr gc "git commit"
abbr gco "git checkout"
abbr gd "git diff"
abbr gf "git fetch"
abbr gm "git merge"
abbr gpff "git pull --ff-only"
abbr gpr "git pull --rebase"
abbr gprr "git pull --rebase --recurse-submodules"
abbr gpull "git pull"
abbr gpush "git push"
abbr gr "git rebase"
abbr gs "git status"

# Neovim
abbr n nvim
abbr lvim "NVIM_APPNAME=lazyvim nvim"
abbr ncust "NVIM_APPNAME=nvim-cust nvim"

#
# Applications
#

# Homebrew
if test -d /opt/homebrew
    set -gx HOMEBREW_BUNDLE_NO_LOCK 1
    /opt/homebrew/bin/brew shellenv | source
end

# Oh My Posh
if command -q oh-my-posh
    oh-my-posh init fish --config ~/.config/oh-my-posh/pure.omp.toml | source

    function repaint_on_bind_mode_change --on-variable fish_bind_mode
        if test $fish_bind_mode != paste
            omp_repaint_prompt
        end
    end

    function set_poshcontext --no-scope-shadowing
        set -e OMP_BIND_MODE
        set -gx OMP_BIND_MODE $fish_bind_mode

        #set -e OMP_GIT_BRANCH
        #
        #if git branch --show-current 2>/dev/null | read -l git_branch
        #    set -gx OMP_GIT_BRANCH $git_branch
        #end
    end
end

#
# Programming Languages
#

# Go
if command -q go
    set -gx GOPATH (go env GOPATH)
    fish_add_path -gP $GOPATH/bin
end

# JavaScript
if command -q nodenv
    nodenv init - | source
end

# Python
if command -q pyenv
    pyenv init - | source
end

# Ruby
if command -q rbenv
    rbenv init - | source
end

# Rust
if test -e ~/.cargo/env.fish
    source ~/.cargo/env.fish
end
