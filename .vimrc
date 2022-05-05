syntax on
set number relativenumber
set numberwidth=5
"set cursorline
"set cursorcolumn
"set mouse=a        " Enable mouse mode
set autoindent
set nowrap
set nobackup
set noswapfile
set colorcolumn=120
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
"}}}

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'alvan/vim-closetag'
Plug 'lilydjwg/colorizer'
call plug#end()
"}}}

" ColorScheme and backgrounds {{{
set background=dark
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
"}}}
