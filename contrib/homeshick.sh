#!/bin/bash

castles="sukima/dotfiles"

prompt_yesno() {
	if [[ $2 = y ]]; then
		def="[Yn]"
	else
		def="[yN]"
	fi
  read -p "$1 $def " answer
  case "$answer" in
    y|Y)
      answer=y
      ;;
    n|N)
      answer=n
      ;;
    *)
      answer=$2
      ;;
  esac
	[[ $answer = y ]]
}

prompt_castle() {
  prompt_yesno "Include the castle $1?" $2
}

if prompt_yesno "Include plugin managers?" y; then
	MANAGER=yes
else
	MANAGER=no
fi

if prompt_castle vimrc y; then
	castles="$castles sukima/vimrc"
	if [[ $MANAGER = yes ]]; then
		castles="$castles gmarik/Vundle.vim"
	fi
fi

if prompt_castle tmuxrc y; then
	castles="$castles sukima/tmuxrc"
	if [[ $MANAGER = yes ]]; then
		castles="$castles tmux-plugins/tpm"
	fi
fi

if prompt_castle muttrc n; then
	castles="$castles sukima/muttrc sukirepoman@tritarget.org:securerc.git"
fi

git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source $HOME/.homesick/repos/homeshick/homeshick.sh

for castle in $castles; do
	homeshick clone $castle
done

# vim: ts=2 sw=2 noet ft=sh fdm=marker
