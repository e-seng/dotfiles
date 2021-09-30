#!/usr/bin/bash

# this is here to set up a new machine? maybe?
# either that or completely bork it lol

# ~~~ setup ~~~
# backup previous dot files in case i mess something up
mkdir .backup
mv .* .backup
mv ~/dotfiles ~/.dotfiles

# install zsh stuff
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ~~~ .config ~~~
# setup .config/
mkdir ~/.config

# link related files
ln -s ~/.dotfiles/.config/nvim ~/.config/

# ~~~ link base folders ~~~
ln -s ~/.dotfiles/.dir_colors ~
ln -s ~/.dotfiles/.zshrc ~
ln -s ~/.dotfiles/.vimrc ~
ln -s ~/bash
