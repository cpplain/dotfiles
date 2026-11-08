# Completions for dotlink (scripts/link)

# Directory sources from the manifest of the repo dotlink lives in.
function __dotlink_dir_sources
    set -l bin (command -s dotlink); or return
    set -l repo (path dirname (path dirname (path resolve $bin)))
    test -f $repo/links; or return
    string replace -r '#.*' '' <$repo/links | string match -rg '^\s*(\S+/)\s'
end

# True until adopt has its <src> argument.
function __dotlink_adopt_needs_src
    set -l tokens (commandline -xpc)
    set -l seen_adopt 0
    set -l skip 0
    for t in $tokens[2..]
        if test $skip = 1
            set skip 0
            continue
        end
        switch $t
            case -t --target -w --when
                set skip 1
            case '-*'
            case adopt
                if test $seen_adopt = 1
                    return 1
                end
                set seen_adopt 1
            case '*'
                test $seen_adopt = 1; and return 1
        end
    end
    return 0
end

set -l cmds create status adopt prune

complete -c dotlink -f
complete -c dotlink -n "not __fish_seen_subcommand_from $cmds" -a create -d "Create symlinks from the manifest"
complete -c dotlink -n "not __fish_seen_subcommand_from $cmds" -a status -d "Show problems and leftovers"
complete -c dotlink -n "not __fish_seen_subcommand_from $cmds" -a adopt -d "Move files into the repo and link them back"
complete -c dotlink -n "not __fish_seen_subcommand_from $cmds" -a prune -d "Remove leftover links and emptied dirs"

complete -c dotlink -s n -l dry-run -d "Preview changes"
complete -c dotlink -s h -l help -d "Show help"
complete -c dotlink -n "__fish_seen_subcommand_from status" -s a -l all -d "Also show ok rows"
complete -c dotlink -n "__fish_seen_subcommand_from adopt" -s t -l target -r -F -d "Target for a new source"
complete -c dotlink -n "__fish_seen_subcommand_from adopt" -s w -l when -x -a "personal work" -d "Profile for a new source"
complete -c dotlink -n "__fish_seen_subcommand_from adopt" -s y -l yes -d "Skip the large-adopt confirmation"
complete -c dotlink -n "__fish_seen_subcommand_from adopt; and __dotlink_adopt_needs_src" -a "(__dotlink_dir_sources)"
complete -c dotlink -n "__fish_seen_subcommand_from adopt; and not __dotlink_adopt_needs_src" -F
