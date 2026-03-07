function fish_prompt --description "Write out the prompt"
    set -l last_status $status
    set -q fish_color_status; or set -g fish_color_status red

    if contains -- --final-rendering $argv
        echo -n "> "
    else
        echo -s (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (fish_git_prompt)

        if test $last_status -ne 0
            set_color $fish_color_status
        end
        echo -n "> "
        set_color normal
    end
end
