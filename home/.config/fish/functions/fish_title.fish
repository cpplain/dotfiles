function fish_title
    set -q argv[1]; or set argv (status current-command)

    echo $argv -- (prompt_pwd)
end
