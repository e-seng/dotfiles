#!/bin/bash

# this is here to set up a new machine? maybe?
# either that or completely bork it lol

# ~~~ setup ~~~
# remove "." from .dotfiles if needed
if test -d ~/.dotfiles; then
  mv ~/.dotfiles ~/dotfiles
fi

# backup previous dot files in case i mess something up
if test -d ~/.backup; then
  echo "~/.backup found"
else
  echo -n "backing-up existing dot files into ~/.backup... "
  mkdir ~/backup
  mv $(find ~ -maxdepth 1 | grep "$HOME/\." | grep -v 'ssh' | grep -v 'nvm') ~/backup
  echo "done"
  mv ~/backup ~/.backup
fi

# rename default folder
echo -n "Renaming dotfiles repository folder"
if test -d ~/dotfiles; then
  mv ~/dotfiles ~/.dotfiles
fi
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
fi

ln -s ~/.dotfiles/.zshrc ~

ln -s ~/.dotfiles/.oh-my-zsh ~

ln -s ~/.dotfiles/.vimrc ~
ln -s ~/.dotfiles/.bashrc ~
ln -s ~/.dotfiles/.gitconfig ~
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

echo -n "Change the default shell: "
sudo chsh -s $(which zsh)
echo "";
