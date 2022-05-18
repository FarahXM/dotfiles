# If not running interactively, don't do anything
[[ $- != *i*  ]] && return

## Prompt 
export PS1="\[\e[34m\]\w\[\e[m\]\[\e[30m\]\\$\[\e[m\] "

# #Sett Completions And bell ...
bind 'set bell-style none'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

##  alias 
alias x='startx'
alias v='vim'
alias h='history'
alias ls='ls --color=auto'
alias ll='ls -l'
alias cc='clear'
alias ss='sxiv'
