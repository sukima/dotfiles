#!/bin/zsh
trace=false
if $trace; then
	start=$(gdate "+%s%N")
	# set the trace prompt to include seconds, nanoseconds, script name and line number
	# PS4='$(($(date "+%s%N")-$start))	%N:%i	'
	PS4='$(($(gdate "+%s%N")-$start)) %N:%i> '
	# save file stderr to file descriptor 3 and redirect stderr (including trace 
	# output) to a file with the script's PID as an extension
	exec 3>&2 2>/tmp/startlog.$$
	# set options to turn on tracing and expansion of commands contained in the prompt
	setopt xtrace prompt_subst
fi

. $HOME/.homesick/repos/dotfiles/zsh/rc.zsh

if $trace; then
	# turn off tracing
	unsetopt xtrace
	# restore stderr to the value saved in FD 3
	exec 2>&3 3>&-
fi
