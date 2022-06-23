" --------------------- Disable arrow keys for normal mode. ------------------"
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

"----------------- Disable arrow keys for insert mode. ---------------------- "
inoremap <up> <Nop>
inoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" ------------- Disable arrow keys for visual mode. ------------------------- "
vnoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>

" -------------- Disable arrow keys for command mode. ---------------------- "
cnoremap <up> <Nop>
cnoremap <down> <Nop>
cnoremap <left> <Nop>
cnoremap <right> <Nop>

" ----------- Toggle the highlighting or clear the highlight ---------------- "
noremap <silent> <leader>hl :set hlsearch!<CR>
noremap <silent> <SPACE> :noh<CR>

"--------------- Center-, right-, or left-align one or more lines. -----------"
noremap <silent> <leader>c :center<CR>
noremap <silent> <leader>r :right<CR>
noremap <silent> <leader>l :left<CR>

" ---------------- Move the current line up or down. ------------------------"
noremap <silent> <C-k> :move -2<CR>
noremap <silent> <C-j> :move +1<CR>

" ------------------- Normal mode remappings --------------------------------"
nnoremap <C-q> :q!<CR>
nnoremap <C-b> :bd<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-s> :sp<CR>:terminal<CR>

" ---------------------------- Tabs ----------------------------------------- "
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <C-t> :tabnew<CR>

"--------------------------- Caps Lock .-------------------------------------"
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

"---------------------------------Sett ----------------------{{{
syntax on
set number relativenumber
set numberwidth=5
set autoindent
set nowrap
set nobackup
set noswapfile
set colorcolumn=80
set noshowmode
set laststatus=2
set belloff=all
set mouse=a       
set cursorline
"set cursorcolumn

	"---------Search--------"
set ignorecase          " Do case insensitive matching
set incsearch           " Show partial matches for a search phrase
set hlsearch            " clear highlights after search

	"---------Tab----------"
set tabstop=4          " Tab size
set shiftwidth=4       " Indentation size
set softtabstop=4      " Tabs/Spaces interop
set expandtab          " Expands tab to spaces
set smarttab           " Better tabs
" ----------------------------------------------------------------}}}
" ---------------------- plugin list -----------------------------{{{
call plug#begin('~/.config/nvim/plugged')
Plug 'tiagovla/tokyodark.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mattn/emmet-vim'
Plug 'lilydjwg/colorizer'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()
" --------------------------------------------------------------{{{
" ------------------- ColorScheme ------------------------------{{{
set background=dark
set laststatus=2
colorscheme tokyodark
let g:lightline = {'colorscheme' : 'tokyonight'}
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
lua << END
require('lualine').setup()
END
" --------------------------------------------------------------}}}
" ------------------- Fzf Serach -------------------------------{{{
nnoremap <C-f> :Files<CR>
nnoremap <C-p> :BLines<CR>
nnoremap <C-g> :GFiles<CR>
" ---------------------------------------------------------------}}}
" ----------------- Emmet Shortcuts -----------------------------{{{
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','
"----------------------------------------------------------------}}}
