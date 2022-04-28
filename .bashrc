#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

############################ myCoustom bash-#################################{{{
####### bash prombut ############
PS1="[\[\e[32m\]\W\[\e[m\]]\\$ "

########### alias ###############

## Run display server Xorg
alias x='startx'

############ Run Vim ############
alias v='vim'

########### Ranger ##############
alias r='ranger'

# Move to the parent folder.
alias ..='cd ..;pwd'

# Press c to clear the terminal screen.
alias c='clear'

# Press h to view the bash history.
alias h='history'

#################################

##### Use vim in bash ##########
#set -o vi

# this line ignore command duplicate in the history
HISTCONTROL=ignoredups 
######################################################################################}}}

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
