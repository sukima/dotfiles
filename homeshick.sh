#!/bin/bash

tmpfilename="/tmp/${0##*/}.XXXXX"

if type mktemp >/dev/null; then
  tmpfile=$(mktemp $tmpfilename)
else
  tmpfile=$(echo $tmpfilename | sed "s/XX*/$RANDOM/")
fi

trap 'rm -f "$tmpfile"' EXIT

cat <<'EOF' > $tmpfile
# Which Homeshick castles do you want to install?
#
# Each line is passed as the argument to `homeshick clone`
#
# Lines starting with '#' will be ignored, and an empty file aborts this
# operation.
#
# If you remove a line that castle will NOT be installed.
#
# However, if you remove everything, the script will be aborted.

# Plugin management
gmarik/Vundle.vim
tmux-plugins/tpm

# Main castles
sukima/dotfiles
sukima/vimrc
sukima/tmuxrc

# Private castles
#sukima/muttrc
#sukirepoman@tritarget.org:securerc.git
EOF

${VISUAL:-vi} $tmpfile

code=$?

if [[ $code != 0 ]]; then
  echo "Editor returned ${code}." 1>&2
  exit 1
fi

castles=()

while read line; do
  castle=$(echo "$line" | sed '/^[ \t]*#/d;s/^[ \t]*\(.*\)[ \t]*$/\1/')
  if [[ -n $castle ]]; then
    castles+=("$castle")
  fi
done <$tmpfile

if [[ ${#castles[@]} -eq 0 ]]; then
  echo "No castles to install. Aborting."
  exit 0
fi

if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh

for castle in "${castles[@]}"; do
  homeshick clone "$castle"
done
