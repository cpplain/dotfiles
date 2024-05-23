#!/usr/bin/env zsh

if [ $# -lt 1 ] || [ ! -d $1 ]; then
    echo "Usage: install.sh <repo_root>"
    exit 1
fi

for file in $1/home/*(D); do
    ln -sF $file ~
done

for file in $1/private/home/**/*(.D); do
    ln -sF $file $(echo $file | sed "s|$1/private/home|$HOME|")
done
