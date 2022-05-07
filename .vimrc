syntax on
set number relativenumber
set numberwidth=5
set autoindent
set cursorline
"set cursorcolumn
"set mouse=a       
set nowrap
set nobackup
set noswapfile
set colorcolumn=100
set noshowmode
set laststatus=2
set belloff=all

	"---------Search--------"
set ignorecase     " Do case insensitive matching
set incsearch      " Show partial matches for a search phrase
set nohlsearch     " clear highlights after search

	"---------Tab----------"
set tabstop=4      " Tab size
set shiftwidth=4   " Indentation size
set softtabstop=4  " Tabs/Spaces interop
set expandtab      " Expands tab to spaces
set smarttab       " Better tabs

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'lilydjwg/colorizer'
call plug#end()
"}}}

" ColorScheme and backgrounds {{{
set background=dark
colorscheme dracula
hi Normal ctermbg=NONE
"}}}
