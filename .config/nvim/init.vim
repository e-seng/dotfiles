set nocompatible
set nowrap

" tabs stuff
filetype plugin indent on
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set cindent

" folding configurations
set foldmethod=indent
set foldlevel=99

" prevent scrolling to the bottom of the screen
set scrolloff=10

" colors please
syntax on
colorscheme habamax
set termguicolors

" set netrw settings
let g:netrw_liststyle = 3

" set automatic newlines
set tw=80 " hard 80 characters :)

" set snippet keybindings
nnoremap ,html :-1read $HOME/.config/nvim/snippets/skeleton.html<CR>3j3wl
