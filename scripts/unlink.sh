#!/usr/bin/env bash

set -e

root=$(echo $(PWD) | sed 's|/scripts||')
source $(dirname ${BASH_SOURCE[0]})/utils.sh

remove_link() {
	if test -L $1; then
		echo "- $1"
		rm -f $1
	fi
}

echo "Removing private dotfile links"
files=$(find_dotfiles -p)
for f in $files; do
	target=$(source_to_target -p $f)
	remove_link $target
done

echo "Removing dotfile links"
files=$(find_dotfiles)
for f in $files; do
	target=$(source_to_target $f)
	remove_link $target
done
