function fish_title
    set -q argv[1]; or set argv (status current-command)

    echo (prompt_pwd): $argv
end
