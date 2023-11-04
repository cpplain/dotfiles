#!/usr/bin/env zsh

directories=(
    .config
    Library/Application\ Support/Code/User
    Library/Application\ Support/iTerm2/DynamicProfiles
)
for directory in $directories; do
    directory=~/$directory
    if [ ! -d $directory ]; then
        echo "Creating $directory"
        mkdir -p $directory
    fi
done

repo_dir=$(dirname $(pwd))/dotfiles/home
dotfiles=(
    .config/git
    .config/nvim
    .config/skhd
    .config/wezterm
    .config/yabai
    .config/starship.toml
    Library/Application\ Support/Code/User/settings.json
    Library/Application\ Support/iTerm2/DynamicProfiles/profiles.json
    .zshrc
)
for file in $dotfiles; do
    source=$repo_dir/$file
    target=~/$file
    if [ -e $target ]; then
        echo "Removing existing link $target"
        rm $target
    fi
    echo "Creating link $target"
    ln -s $source $target
done

repo_dir=$(dirname $(pwd))/dotfiles-private/home
dotfiles=(
    .config/git-private
)
for file in $dotfiles; do
    source=$repo_dir/$file
    target=~/$file
    if [ -e $target ]; then
        echo "Removing existing link $target"
        rm $target
    fi
    echo "Creating link $target"
    ln -s $source $target
done
