##############################################################################
############################### Fish_Config ##################################
##############################################################################
## greeting Message 
set fish_greeting # find Coustom in ~/.config/fish/functions/fish_greeting.fish

## Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

################################ Alias #######################################
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Changing "ls" to "exa"
alias l='exa --icons'
alias ls='exa --color=auto --icons'
alias ll='exa -lah --icons'
alias la='exa -a --icons'
alias lt='exa --tree --level=2 --icons'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# bat && find
alias cat='bat'
alias find='fd'

# Editor Vim NeoVim
alias v='vim'
alias vi="vim"
alias nv="nvim"
alias vim="nvim"

# V && X && C & H & N
alias x='startx'
alias h='history'
alias n='clear && neofetch'
alias c='clear'
alias cc='clear'

# Pacman && yay
alias 'update'='sudo pacman -Sy && yay -Sy'
alias 'upgrade'='sudo pacman -Syu && echo "UPGRADED"'
alias 'ps'='sudo pacman -S'
alias 'psy'='sudo pacman -Sy'
alias 'pr'='sudo pacman -Rsn'
