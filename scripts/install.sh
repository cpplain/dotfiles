#!/usr/bin/env bash

set -e

help() {
	echo "usage: $(basename ${BASH_SOURCE[0]}) -p | -w"
	echo "       -p    personal"
	echo "       -w    work"
}

if test $# -ne 1; then
	help
	exit 1
fi

while getopts ":pw" opt; do
	case $opt in
	p)
		echo "Setting env to personal"
		echo "personal" >~/.env
		;;
	w)
		echo "Setting env to work"
		echo "work" >~/.env
		;;
	\?)
		help
		exit 1
		;;
	esac
done

./link.sh
./install-brew.sh
./install-packages.sh
