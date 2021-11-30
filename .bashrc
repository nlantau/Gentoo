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

#set -o vi

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
pathprepend $HOME/.cargo/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nlantau/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nlantau/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nlantau/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nlantau/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda deactivate
# <<< conda initialize <<<

. "$HOME/.cargo/env"
