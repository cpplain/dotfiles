#!/usr/bin/env bash

set -e

if test ! -e ~/.env; then
	echo "Environment not set. You must run 'install.sh -p | -w' first."
	exit 1
fi

brew=/opt/homebrew/bin/brew
if test $(uname -m) == x86_64; then
	brew=/usr/local/bin/brew
fi

brewfile=~/.config/Brewfile
if test $(grep work ~/.env); then
	brewfile=~/.config/Brewfile_work
fi

echo "Installing Homebrew packages"
echo "Using file '$brewfile'"
eval "$($brew shellenv)"
$brew bundle --file $brewfile --verbose --force --no-lock
