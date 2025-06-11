function sync_worktree_files --description "Sync untracked worktree files between worktrees and backup"
    set current_worktree (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$current_worktree"
        echo "Error: Not in a git repository"
        return 1
    end

    set main_worktree ""
    for line in (git worktree list --porcelain | grep "^worktree ")
        set path (string replace "worktree " "" $line)
        if test -d "$path/.git"
            set main_worktree $path
            break
        end
    end

    if test -z "$main_worktree"
        echo "Error: Could not find main worktree"
        return 1
    end

    set repo_name (basename $main_worktree)
    set worktree_name (basename $current_worktree)
    set backup_base "$HOME/git-worktree-files/$repo_name"

    set config_file "$backup_base/.rsyncfiles"
    if not test -f "$config_file"
        return 0 # No config file
    end

    if test "$current_worktree" = "$main_worktree"
        set backup_dir $backup_base
    else
        set backup_dir "$backup_base/$worktree_name"
    end

    if not test -d "$backup_dir"
        mkdir -p "$backup_dir"
    end

    echo "Syncing worktree files for $worktree_name"

    set sync_count 0
    set copy_count 0

    for line in (cat "$config_file" | grep -v "^#" | grep -v "^[[:space:]]*\$")
        set item (string trim "$line")
        if test -z "$item"
            continue
        end

        if test "$current_worktree" != "$main_worktree" -a ! -e "$current_worktree/$item"
            if test -e "$main_worktree/$item"
                set parent (dirname "$current_worktree/$item")
                if not test -d "$parent"
                    mkdir -p "$parent"
                end

                if test -d "$main_worktree/$item"
                    cp -R "$main_worktree/$item" "$current_worktree/$item"
                    echo "Copied directory from main: $item"
                else
                    cp "$main_worktree/$item" "$current_worktree/$item"
                    echo "Copied file from main: $item"
                end
                set copy_count (math $copy_count + 1)
            end
        end

        if test -e "$current_worktree/$item"
            set backup_parent (dirname "$backup_dir/$item")
            if not test -d "$backup_parent"
                mkdir -p "$backup_parent"
            end

            if test -d "$current_worktree/$item"
                rsync -a --delete "$current_worktree/$item/" "$backup_dir/$item/"
            else
                rsync -a "$current_worktree/$item" "$backup_dir/$item"
            end
            set sync_count (math $sync_count + 1)
        end
    end

    if test $copy_count -gt 0
        echo "Copied $copy_count file(s) from main worktree"
    end

    if test $sync_count -gt 0
        echo "Synced $sync_count file(s) to backup: $backup_dir"
    end
end
