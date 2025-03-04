#!/usr/bin/env bash

source ~/.env || { echo "Unable to source .env" && exit 1; }

pub_home=$DOTFILES_REPO_DIR/home
prv_home=$DOTFILES_REPO_DIR/private/home

create_links() {
    echo "Creating links"
    find $pub_home -depth 1 | sed "s|$pub_home/||" | sort | xargs -I % bash -c "ln -sF $pub_home/% ~/%; echo ~/%"
    find $prv_home -type f | sed "s|$prv_home/||" | sort | xargs -I % bash -c "ln -sf $prv_home/% ~/%; echo ~/%"
}

prune_links() {
    echo "Pruning broken links"
    find -L ~ -path ~/Library -prune -o -lname $DOTFILES_REPO_DIR/\* -exec rm -f {} \; -print 2>/dev/null
}

remove_links() {
    echo "Removing all links"
    find ~ -path ~/Library -prune -o -lname $DOTFILES_REPO_DIR/\* -exec rm -f {} \; -print 2>/dev/null
}
