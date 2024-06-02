#!/usr/bin/env bash

set -e

arch=$(uname -m)
brew=/opt/homebrew/bin/brew
test "x86_64" == $arch && brew=/usr/local/bin/brew

if test -e $brew; then
	echo "Homebrew already installed"
	exit 0
fi

echo "Installing Homebrew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
