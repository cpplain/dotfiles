#!/usr/bin/env bash

find_dotfiles() {
	while getopts ":p" opt; do
		case $opt in
		p)
			is_private=true
			;;
		\?)
			echo "Invalid option: -$OPTARG"
			exit 1
			;;
		esac
	done

	if test $is_private; then
		echo $(find $root/private/home -type f)
		return
	fi

	echo $(find $root/home -depth 1)
}

source_to_target() {
	while getopts ":p" opt; do
		case $opt in
		p)
			is_private=true
			;;
		\?)
			echo "Invalid option: -$OPTARG"
			exit 1
			;;
		esac
	done
	shift $(($OPTIND - 1))

	if test $is_private; then
		echo $(echo $1 | sed "s|$root/private/home|$HOME|")
		return
	fi

	echo $(echo $1 | sed "s|$root/home|$HOME|")
}
