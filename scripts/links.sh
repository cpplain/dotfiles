#!/usr/bin/env bash

source ~/.env || { echo "Unable to source .env" && exit 1; }

pub_home=$DOTFILES_REPO_DIR/home
prv_home=$DOTFILES_REPO_DIR/private/home

find_dirs() {
	{ cd $1 && find .config -type d -mindepth 1; }
}

find_files() {
	{ cd $1 && find .config -type f; } | sort
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
	echo "Pruning links"
	find -L ~ -path ~/Library -prune -o -lname $DOTFILES_REPO_DIR/\* -print | xargs rm -f
}

remove_links() {
	echo "Removing links"
	{ find_files $pub_home && find_files $prv_home; } |
		xargs -I % bash -c '[ -L ~/% ] && rm -f ~/% && echo ~/%'
}
