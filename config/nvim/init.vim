" Options
set number
set relativenumber
set numberwidth=5
set autoindent
set nowrap
set nobackup
set noswapfile
set colorcolumn=110
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Syntax 
filetype plugin indent on
syntax on
set t_Co=256

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" Plugine
call plug#begin('~/.config/nvim/plugged')
    " Appearance
    Plug 'tiagovla/tokyodark.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'lukas-reineke/indent-blankline.nvim'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mattn/emmet-vim'
    Plug 'alvan/vim-closetag'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf.vim'

    " Completion / linters / formatters
    Plug 'plasticboy/vim-markdown'

    " Git
    Plug 'airblade/vim-gitgutter'
call plug#end()

" Aesthetics
colorscheme tokyodark
let g:lightline = {'colorscheme' : 'tokyonight'}
set laststatus=2
hi Normal guibg=NONE ctermbg=NONE


" emmet shortcuts
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','

" fzf search
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :BLines<CR>
nnoremap <C-g> :GFiles<CR>

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :sp<CR>:terminal<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

lua << EOF
require('lualine').setup()
EOF

