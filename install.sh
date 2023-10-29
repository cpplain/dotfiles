#!/usr/bin/env zsh

directories=(
    .config
    Library/Application\ Support/Code/User
    Library/Application\ Support/iTerm2/DynamicProfiles
)
for directory in $directories; do
    if [ ! -d ~/$directory ]; then
        echo "Creating ~/$directory"
        mkdir -p ~/$directory
    fi
done

parent=$(dirname $(pwd))

repo=$parent/dotfiles/home
dotfiles=(
    .config/git
    .config/nvim
    .config/skhd
    .config/yabai
    Library/Application\ Support/Code/User/settings.json
    Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json
    .zshrc
)
for file in $dotfiles; do
    echo "Creating symlink ~/$file"
    if [ -e ~/$file ]; then
        rm ~/$file
    fi
    ln -s $repo/$file ~/$file
done

repo=$parent/dotfiles-private/home
dotfiles=(
    .config/git-private
)
for file in $dotfiles; do
    echo "Creating symlink ~/$file"
    if [ -e ~/$file ]; then
        rm ~/$file
    fi
    ln -s $repo/$file ~/$file
done
