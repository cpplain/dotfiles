set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_RUNTIME_DIR $TMPDIR

set -gx EDITOR nvim

set -g fish_greeting # disable fish greeting
set -g fish_prompt_pwd_dir_length 0
set -g fish_transient_prompt 1

#
# Abbreviations
#

# Homebrew
abbr bb "brew update && brew bundle --global --verbose --force"
abbr bbc "brew update && brew bundle cleanup --global --verbose --force"

# Claude Code
abbr ccd "claude --dangerously-skip-permissions"
abbr ccpa "claude --permission-mode plan --allow-dangerously-skip-permissions"

# Git
abbr g git
abbr ga "git add"
abbr gb "git branch"
abbr gc "git commit"
abbr gca "git commit --amend"
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
abbr gwa add_worktree
abbr gwl "git worktree list"
abbr gwr remove_worktree
abbr gws sync_worktree_files

# Link Manager
abbr lna "lnk adopt --path"
abbr lnc "lnk create"
abbr lno "lnk orphan --path"
abbr lnp "lnk prune"
abbr lnr "lnk remove"
abbr lns "lnk status"

# Neovim
abbr n nvim

#
# Applications
#

# Homebrew
if test -d /opt/homebrew
    set -gx HOMEBREW_BUNDLE_NO_LOCK 1
    /opt/homebrew/bin/brew shellenv | source

    fish_add_path -gP /opt/homebrew/lib/ruby/gems/3.4.0/bin
end

# Local binaries
fish_add_path -gP ~/.local/bin

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

# Zig
if test -e ~/.zig/zig
    fish_add_path -gP ~/.zig
end
