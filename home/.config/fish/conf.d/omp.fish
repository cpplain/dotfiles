oh-my-posh init fish --config ~/.config/omp.toml | source

function repaint_on_bind_mode_change --on-variable fish_bind_mode
    if test $fish_bind_mode != paste
        omp_repaint_prompt
    end
end

function set_poshcontext --no-scope-shadowing
    set -e OMP_BIND_MODE
    set -e OMP_GIT_BRANCH

    set -gx OMP_BIND_MODE $fish_bind_mode

    if git branch --show-current 2>/dev/null | read -l git_branch
        set -gx OMP_GIT_BRANCH $git_branch
    end
end
