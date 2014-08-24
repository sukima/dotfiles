#!/bin/zsh
export CLICOLOR=1
export LSCOLORS="gxfxcxdxbxegedabagacad"

bindkey "^[[3~" delete-char

if [[ -x /usr/local/bin/gls ]]; then
    alias ls='/usr/local/bin/gls -h --color=auto'
else
    alias ls='ls -hG'
fi

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi