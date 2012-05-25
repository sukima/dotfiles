# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Convinience method to check if a command exists or not.
command_exists () {
    hash "$1" &> /dev/null
}

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# CTRL-D will logout of shell after 2 tries (ignore 1st CTRL-D)
IGNOREEOF=1

# allow CTRL-S to work
stty stop undef

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Modules
# Loading of other bash modules
if test -e "$HOME/.bash_modules" ; then
    if command_exists "readlink" ; then
        mod_path=$(dirname "$(readlink $HOME/.bashrc)")
        mod_path=$(cd "$mod_path/../bash_modules.d" && pwd)
    elif test -d "$HOME/.dotty/default/dotfiles/bash_modules.d" ; then
        mod_path="$HOME/.dotty/default/dotfiles/bash_modules.d"
    else
        mod_path="$HOME/.bash_modules.d"
    fi
    mod_files=$(sed -e 's/#.*//' -e 's/[ 	]*$//' -e 's/^[ 	]*//' -e '/^$/ d' "$HOME/.bash_modules")
    OLDIFS=IFS
    IFS=$'\n'
    for confline in $mod_files; do
        [[ -r "$mod_path/$confline" ]] && source "$mod_path/$confline"
    done
    IFS=$OLDIFS
fi

# Fix PS1 if git-completion module was loaded
if command_exists "__git_ps1" ; then
    PS1=$(echo "$PS1" | sed -e 's/\\\$ $/$(__git_ps1 " (%s)")\\$ /')
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Source local_basrc for backwartds compatability
[[ -f "$HOME/.local_bashrc" ]] && . "$HOME/.local_bashrc"

# vim:set ft=sh sw=4 et fdm=marker :
