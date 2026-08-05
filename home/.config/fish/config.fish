set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state
set -gx XDG_RUNTIME_DIR $TMPDIR

set -gx EDITOR nvim

if test -f ~/.dotfilesenv
    read -gx DOTFILES_ENV <~/.dotfilesenv
end

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
abbr ccc "claude -p \"/commit\""
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
abbr lna "lnk adopt"
abbr lnc "lnk create"
abbr lno "lnk orphan"
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
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    fish_add_path -gm /opt/homebrew/bin /opt/homebrew/sbin
    if test -n "$MANPATH[1]"
        set -gx MANPATH '' $MANPATH
    end
    if not contains /opt/homebrew/share/info $INFOPATH
        set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
    end

    fish_add_path -gP /opt/homebrew/lib/ruby/gems/3.4.0/bin
end

# Local binaries
fish_add_path -gP ~/.local/bin

#
# Programming Languages
#

# Go
set -gx GOPATH $HOME/go
fish_add_path -gP $GOPATH/bin

# JavaScript
if test -d ~/.nodenv
    fish_add_path -gP ~/.nodenv/shims
    set -gx NODENV_SHELL fish
    function nodenv
        set -l command $argv[1]
        set -e argv[1]
        switch "$command"
            case rehash shell
                nodenv "sh-$command" $argv | source
            case '*'
                command nodenv "$command" $argv
        end
    end
end

# Python
if test -d ~/.pyenv
    fish_add_path -gP ~/.pyenv/shims
    set -gx PYENV_SHELL fish
    function pyenv
        set -l command $argv[1]
        set -e argv[1]
        switch "$command"
            case rehash shell
                source (pyenv "sh-$command" $argv | psub)
            case '*'
                command pyenv "$command" $argv
        end
    end
end

# Ruby
if test -d ~/.rbenv
    fish_add_path -gP ~/.rbenv/shims
    set -gx RBENV_SHELL fish
    function rbenv
        set -l command $argv[1]
        set -e argv[1]
        switch "$command"
            case rehash shell
                rbenv "sh-$command" $argv | source
            case '*'
                command rbenv "$command" $argv
        end
    end
end

# Rust
if test -e ~/.cargo/env.fish
    source ~/.cargo/env.fish
end
