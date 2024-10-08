filetype on
syntax on
set tabstop=4
set smartindent
set autoindent
set shiftwidth=4
set nobackup
set noswapfile
set viminfo="NONE"
set relativenumber
set clipboard=unnamed
set nocompatible

" Plugins
call plug#begin()
Plug 'tmsvg/pear-tree'
Plug 'preservim/nerdtree'
call plug#end()

" Pear Tree
let g:pear_tree_repeatable_expand = 0

" Nerd Tree
nnoremap <C-S-K> :NERDTreeToggle<CR>
