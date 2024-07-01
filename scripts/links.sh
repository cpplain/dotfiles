#!/usr/bin/env bash

source ~/.env || { echo "Unable to source .env" && exit 1; }

pub_home=$DOTFILES_REPO_DIR/home
prv_home=$DOTFILES_REPO_DIR/private/home

find_dirs() {
	find $1 -type d -mindepth 1 | sed "s|$1/||" | sort
}

find_files() {
	find $1 -type f | sed "s|$1/||" | sort
}

create_links() {
	echo "Creating directories"
	{ find_dirs $pub_home && find_dirs $prv_home; } |
		sort | uniq | xargs -I % bash -c 'mkdir -p ~/%; echo ~/%'

	echo "Creating links"
	find_files $pub_home | xargs -I % bash -c "ln -sf $pub_home/% ~/%; echo ~/%"
	find_files $prv_home | xargs -I % bash -c "ln -sf $prv_home/% ~/%; echo ~/%"
}

prune_links() {
	echo "Pruning broken links"
	find -L ~ -path ~/Library -prune -o -lname $DOTFILES_REPO_DIR/\* -exec rm -f {} \; -print 2>/dev/null
}

remove_links() {
	echo "Removing links"
	find ~ -path ~/Library -prune -o -lname $DOTFILES_REPO_DIR/\* -exec rm -f {} \; -print 2>/dev/null
}
