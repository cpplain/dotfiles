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

brew_bundle() {
    echo "Running brew bundle"
    brew update
    brew bundle --global --verbose --force --no-lock
}

bundle_cleanup() {
    echo "Running brew bundle cleanup"
    brew update
    brew bundle cleanup --global --verbose --force --no-lock
}
