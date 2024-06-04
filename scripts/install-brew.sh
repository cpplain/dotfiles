#!/usr/bin/env bash

set -e

arch=$(uname -m)
brew=/opt/homebrew/bin/brew
if test "x86_64" == $arch; then
	brew=/usr/local/bin/brew
fi

if test -e $brew; then
	echo "Homebrew already installed"
	exit 0
fi

echo "Installing Homebrew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
