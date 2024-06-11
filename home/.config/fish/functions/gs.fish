function gs --wraps git --description "alias gs=git status -sb --show-stash"
    git status -sb --show-stash $argv
end
