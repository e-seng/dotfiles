#!/bin/bash

# this is here to set up a new machine? maybe?
# either that or completely bork it lol

# ~~~ setup ~~~
# backup previous dot files in case i mess something up
echo -n "backing-up existing dot files into ~/.backup... "
mkdir ~/.backup
mv ~/.* .backup
echo "done"

# rename default folder
echo -n "Renaming dotfiles repository folder"
if test -d ~/dotfiles; then
  mv ~/dotfiles ~/.dotfiles
fi
echo "done"

# install zsh stuff
echo "installing zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "done"

# ~~~ .config ~~~
# setup .config/
echo "creating ~/.config";
mkdir ~/.config

# link related files
echo -n "linking .config files... "
ln -s ~/.dotfiles/.config/nvim ~/.config/
echo "done"

# ~~~ link base folders ~~~
echo -n "linking other dot files into ~... "
ln -s ~/.dotfiles/.dir_colors ~

# replace default .zshrc
if test -f ~/.zshrc; then
  rm ~/.zshrc
  ln -s ~/.dotfiles/.zshrc ~
fi

ln -s ~/.dotfiles/.vimrc ~
ln -s ~/.bashrc ~
echo "done"

# conditionals:
echo "let's try not to overwrite anything that might be important..."
if test -d ~/.ssh;then
  echo "~/.ssh found, skipping..."
else
  mkdir ~/.ssh/
  ln -s ~/.dotfiles/.ssh/config ~/.ssh
fi

if test -d ~/.vim;then
  echo "~/.vim found, skipping..."
else
  mkdir ~/.vim
fi
echo "done"
