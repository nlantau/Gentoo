#!/bin/bash
# nlantau, 2021-06-27

#################################################
#
#       Total mess. Needs proper structure.
#
#
#################################################

# Disable ctrl-s and ctrl-q.

aliasrc="/home/nlantau/.aliasrc"
bashenv="/home/nlantau/.bashenv"

[[ -f $bashenv ]] && source $bashenv
[[ -f $aliasrc ]] && source $aliasrc

stty -ixon 
shopt -s autocd

export EDITOR='vim'
export VISUAL='vim'
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

pathappend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

pathprepend() {
  for ((i=$#; i>0; i--)); 
  do
    ARG=${!i}
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}


alias ls='ls --color'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfile/ --work-tree=$HOME' 


LS_COLORS='di=1;35:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90:*.png=35:*.gif=36:*.jpg=35:*.c=92:*.jar=33:*.py=93:*.h=90:*.txt=94:*.doc=90:*.docx=90:*.odt=90:*.csv=90:*.xlsx=90:*.xlsm=90:*.rb=31:*.cpp=92:*.sh=92:*.html=96:*.zip=4;33:*.tar.gz=4;33:*.mp4=90:*.mp3=90'
export LS_COLORS
pathappend $HOME/.config/scripts
