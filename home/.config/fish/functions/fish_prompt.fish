function fish_prompt --description "Write out the prompt"
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus
    set -l last_pipestatus $pipestatus
    set -l cwd (set_color $fish_color_cwd)(prompt_pwd | path basename)
    set -l normal (set_color normal)
    set -q fish_color_status; or set -g fish_color_status red

    # Write pipestatus
    # If the status was carried over, don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # echo -n -s $cwd $normal (fish_git_prompt) $normal " "$prompt_status "> "
    echo -n -s "> "
end
