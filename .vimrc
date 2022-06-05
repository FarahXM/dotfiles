" ------------- Disable arrow keys for normal mode. ----------------"
noremap <up> <Nop>
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>

"-------------Disable arrow keys for insert mode. ----------------- "
inoremap <up> <Nop>
inoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>

" ------------ Disable arrow keys for visual mode. ---------------- "
vnoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>

" ------------ Disable arrow keys for command mode. ---------------- "
cnoremap <up> <Nop>
cnoremap <down> <Nop>
cnoremap <left> <Nop>
cnoremap <right> <Nop>

" --------- Toggle the highlighting or clear the highlight -------------- "
noremap <silent> <leader>hl :set hlsearch!<CR>
noremap <silent> <SPACE> :noh<CR>

"------------- Center-, right-, or left-align one or more lines. ---------"
noremap <silent> <leader>c :center<CR>
noremap <silent> <leader>r :right<CR>
noremap <silent> <leader>l :left<CR>

" ---------------- Move the current line up or down. ------------------------"
noremap <silent> <C-k> :move -2<CR>
noremap <silent> <C-j> :move +1<CR>

"--------------------------- Caps Lock .-------------------------------------"
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" --------------------------- Cursor ----------------------------------------"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"---------------------------------Sett ----------------------{{{
syntax on
set number relativenumber
set numberwidth=5
set autoindent
set nowrap
set nobackup
set noswapfile
set colorcolumn=110
set noshowmode
set laststatus=2
set belloff=all
" set mouse=a       
"set cursorline
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
"----------------------------------------------------------------}}}

" -----------------Plugins ----------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'ghifarit53/tokyonight-vim'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'lilydjwg/colorizer'
Plug 'pangloss/vim-javascript'
call plug#end()
"---------------------------------------------}}}

" ------- ColorScheme and backgrounds ------ {{{
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:airline_theme = "tokyonight"
colorscheme tokyonight
hi Normal ctermbg=NONE
" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" For Vim<8, replace EndOfBuffer by NonText
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
"}}}

" -------------Indent Line -----------------{{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"}}}

" ---------------Emmet Vim Html 5 -------------{{{
" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode."
" }}}
