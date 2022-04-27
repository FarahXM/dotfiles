#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

############################ myCoustom bash-#################################{{{

########### alias ###############

## Run display server Xorg
alias x='startx'

# Move to the parent folder.
alias ..='cd ..;pwd'

# Press c to clear the terminal screen.
alias c='clear'

# Press h to view the bash history.
alias h='history'

#################################

####### bash prombut ############
export PS1="[\[\e[32m\]\W\[\e[m\]]\\$ "

##### Use vim in bash ##########
set -o vi

# this line ignore command duplicate in the history
HISTCONTROL=ignoredups 

######################################################################################}}}
