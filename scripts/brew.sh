#!/usr/bin/env bash

set -e

if ! which brew >/dev/null; then
	case $(uname -sm) in
	"Darwin arm64")
		eval "$(/opt/homebrew/bin/brew shellenv)"
		;;
	*)
		eval "$(/usr/local/bin/brew shellenv)"
		;;
	esac
fi

source ~/.env || echo "Unable to source .env"

case $CONFIG_ENV in
personal)
	brewfile=~/.config/Brewfile
	;;
work)
	brewfile=~/.config/Brewfile_work
	;;
esac

brew_bundle() {
	echo "Running brew bundle"
	echo "Using brewfile: $brewfile"
	brew update
	brew bundle --file $brewfile --verbose --force --no-lock
}
