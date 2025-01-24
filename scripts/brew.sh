#!/usr/bin/env bash

set -e

source ~/.env || { echo "Unable to source .env" && exit 1; }

if ! which brew >/dev/null; then
    case $(uname -sm) in
    "Darwin arm64")
        brew=/opt/homebrew/bin/brew
        ;;
    *)
        brew=/usr/local/bin/brew
        ;;
    esac

    ! [ -x $brew ] && echo "Unable to find brew" && exit 1
    eval "$($brew shellenv)"
fi

case $CONFIG_ENV in
personal)
    brewfile=~/.config/homebrew/Brewfile
    ;;
work)
    brewfile=~/.config/homebrew/work/Brewfile
    ;;
esac

brew_bundle() {
    echo "Running brew bundle"
    echo "Using brewfile: $brewfile"
    brew update
    brew bundle --file $brewfile --verbose --force --no-lock
}

bundle_cleanup() {
    echo "Running brew bundle cleanup"
    echo "Using brewfile: $brewfile"
    brew update
    brew bundle cleanup --file $brewfile --verbose --force --no-lock
}
