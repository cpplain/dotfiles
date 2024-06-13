#!/usr/bin/env bash

set -e

source ~/.env || { echo "Unable to source .env" && exit 1; }

find_dotfiles() {
	case $1 in
	--public)
		echo $(find $DOTFILES_REPO_DIR/home -depth 1)
		;;
	--private)
		echo $(find $DOTFILES_REPO_DIR/private/home -type f)
		;;
	esac
}

source_to_target() {
	case $1 in
	--public)
		echo $(echo $2 | sed "s|$DOTFILES_REPO_DIR/home|$HOME|")
		;;
	--private)
		echo $(echo $2 | sed "s|$DOTFILES_REPO_DIR/private/home|$HOME|")
		;;
	esac
}

create_link() {
	test -L $2 && rm -f $2 && echo "- $2"
	ln -s $1 $2 && echo "+ $2 -> $1"
}

create_links() {
	echo "Creating public dotfile links"
	files=$(find_dotfiles --public)
	for f in $files; do
		target=$(source_to_target --public $f)
		create_link $f $target
	done

	echo "Creating private dotfile links"
	files=$(find_dotfiles --private)
	for f in $files; do
		target=$(source_to_target --private $f)
		create_link $f $target
	done
}

remove_link() {
	test -L $1 && rm -f $1 && echo "- $1"
}

remove_links() {
	echo "Removing private dotfile links"
	files=$(find_dotfiles --private)
	for f in $files; do
		target=$(source_to_target --private $f)
		remove_link $target
	done

	echo "Removing public dotfile links"
	files=$(find_dotfiles --public)
	for f in $files; do
		target=$(source_to_target --public $f)
		remove_link $target
	done
}
