oh-my-posh init fish --config ~/.config/omp.toml | source

function set_poshcontext
    set -e OMP_MODE
    set -e OMP_GIT_BRANCH

    set -gx OMP_MODE $fish_bind_mode

    if git branch --show-current 2>/dev/null | read -l git_branch
        set -gx OMP_GIT_BRANCH $git_branch
    end
end
