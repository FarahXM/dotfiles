#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

############## Prompt ##############
export PS1="\[\e[33m\][\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]:\[\e[m\]\[\e[32m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\]\[\e[31m\]\\$\[\e[m\] "
############## alias ###############
alias x='startx'
alias v='vim'
alias h='history'
alias l='ls'
alias ll='ls -l'
alias cc='clear'
alias ss='sxiv'
###################################
## Completions 
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
## Stop bell
bind 'set bell-style none'
