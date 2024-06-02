#!/usr/bin/env bash

set -e

arch=$(uname -m)
brew=/opt/homebrew/bin/brew
test "x86_64" == $arch && brew=/usr/local/bin/brew

echo "Installing Homebrew packages"
eval "$($brew shellevn)"
$brew bundle --global --verbose --force --no-lock
