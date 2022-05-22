#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

################################################ My Coustom ##################################################
## Prompt 
export PS1="\[\e[34m\]\w\[\e[m\]\[\e[30m\]\\$\[\e[m\] "

## Sett Completions And bell ...
bind 'set bell-style none'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

##  alias 
alias x='startx'
alias v='vim'
alias h='history'
alias ll='ls -l'
alias cc='clear'
alias ss='sxiv'
alias ss='sxiv'
alias cat='bat'

############################################ Fuzzy Finder #####################################################
export FZF_DEFAULT_OPTS='--multi --reverse --cycle --border --preview "bat --color=always --style=numbers --line-range=:500 {}" --height 40 --color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'
export FZF_CTRL_T_OPTS="--select-1 --exit-0"

######## Change Directory #########
# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# cdd - cd to selected directory
cdd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# cda - including hidden directories
cda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

############### Opening files ###############
# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
vf() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
