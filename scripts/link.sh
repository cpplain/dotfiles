#!/usr/bin/env bash

set -e

root=$(echo $(PWD) | sed 's|/scripts||')
source $(dirname ${BASH_SOURCE[0]})/utils.sh

create_link() {
	if test -L $2; then
		echo "- $2"
		rm -f $2
	fi
	echo "+ $2 -> $1"
	ln -s $1 $2
}

echo "Creting dotfile links"
files=$(find_dotfiles)
for f in $files; do
	target=$(source_to_target $f)
	create_link $f $target
done

echo "Creating private dotfile links"
files=$(find_dotfiles -p)
for f in $files; do
	target=$(source_to_target -p $f)
	create_link $f $target
done
