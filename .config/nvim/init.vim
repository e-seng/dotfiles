" use vimrc instead, 
" stolen from https://github.com/Green-Avocado/dotfiles/blob/master/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

