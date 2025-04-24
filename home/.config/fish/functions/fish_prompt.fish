function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l status_color (set_color $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$status_color" $last_pipestatus)

    echo -n -s (path basename (prompt_pwd))" " (fish_git_prompt "(%s) ") $prompt_status" " "> "
end
