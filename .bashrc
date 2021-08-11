#!/bin/bash
# nlantau, 2021-06-27
# updated, 2021-07-28

#################################################
#
#       Total mess. Needs proper structure.
#       One day... I'll get to it 
#
#
#################################################


aliasrc="/home/nlantau/.aliasrc"
bashenv="/home/nlantau/.bashenv"

[[ -f $bashenv ]] && source $bashenv
[[ -f $aliasrc ]] && source $aliasrc

umask 022 # fp 644, dp 755
shopt -s autocd

set -o vi

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

pathappend $HOME/.config/scripts $HOME/.local/bin /usr/local
