set nocompatible
set nowrap

" tabs stuff
filetype plugin indent on
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set smarttab
" show nesting depth
set lcs=tab:>-,multispace:\|\ \:\ \|\ \ \ 
set list

" folding configurations
set foldmethod=indent
set foldlevel=99

" prevent scrolling to the bottom of the screen
set scrolloff=10

" colors please
syntax on
colorscheme sorbet
set termguicolors

" set netrw settings
let g:netrw_liststyle = 3

" set automatic newlines
set tw=80 

" set snippet keybindings
nnoremap ,html :-1read $HOME/.config/nvim/snippets/skeleton.html<CR>3j3wl
nnoremap ,make :-1read $HOME/.config/nvim/snippets/makefile.snippet<CR>j2wv2e
nnoremap ,writeup :-1read /home/petiole/.config/nvim/snippets/writeup_skeleton.md<CR>ggllv17l

" fuzz through child directories for easier file access
set path+=**
set wildmenu

" integrate with ctags to allow for multi-file function definition
" requires ctags
command! MakeTags !ctags -R .
set tags=./tags;/
