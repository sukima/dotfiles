#!/bin/bash
#
# This is a shell script that installs proper links and creates an initial
# bash_modules file. This is used for instalations that do not use Dotty.
#
# Copyright (C) 2012, Devin Weaver
# This work is part of my dotfiles project at http://github.com/sukima/dotfiles
# It is licensed under a Creative Commons Attribution 3.0 Unported License.

display_usage() {
    echo >&2 "Usage: install.sh [-h][-I][-f] [-d prefix]"
}

display_help() {
    display_usage
    echo >&2 "  -I,--no-install           Do not install symlinks (.bashrc, etc)"
    echo >&2 "  -f,--force                Force overwriting bashrc, etc. ** DESTRUCTIVE **"
    echo >&2 "  -h,--help                 This cruft"
    echo >&2 "  -d,--dir prefix           Install to prefix instead of default \$HOME"
    echo >&2 "Cannot concatinate arguments (-If will not work, use -I -f instead)."
}

FORCE=no
NO_INSTALL_ARG=no
DIR=`dirname $0`
PREFIX="$HOME"

while test -n "$1"; do
    case "$1" in
        -I|--no-install) NO_INSTALL_ARG="yes" ;;
        -f|--force) FORCE="yes" ;;
        -d|--prefix)
            test -n "$2" || { display_usage; exit 128; }
            PREFIX=$2;
            shift
            ;;
        -h|--help) display_help; exit 128 ;;
        *) display_usage; exit 128 ;;
    esac
    shift
done

# Symlinks
if test "$NO_INSTALL_ARG" = "yes"; then
    echo "Skipping bashrc et al install."
else
    for p in $DIR/dotfiles/.*; do
        x=`basename $p`
        if test "$x" == "." -o "$x" == ".."; then
            : # Skip ./ and ../
        else
            if test "$FORCE" = "yes"; then
                test -e "$PREFIX/$x" && { rm -rf "$PREFIX/$x"; echo "$PREFIX/$x DESTROYED!"; }
            fi
            if test -e "$PREFIX/$x"; then
                echo "$PREFIX/$x exists. Skipping. (Using -f will destroy it!)"
            else
                ln -s "$p" "$PREFIX/$x"
            fi
        fi
    done
fi

# bash_modules
if test "$FORCE" = "yes"; then
    test -e "$PREFIX/.bash_modules" && { rm -rf "$PREFIX/.bash_modules"; echo "$PREFIX/.bash_modules DESTROYED!"; }
fi
if test -e "$PREFIX/.bash_modules"; then
    echo "$PREFIX/.bash_modules exists. Skipping generation. (Using -f will overwrite it!)"
else
    cat <<EOF > $PREFIX/.bash_modules
# bash_modules - defines what modules to load into the bash environment
# Repository at http://github.com/sukima/dotfiles
# Generated for the first time by repository install.sh.
#
# Uncomment any of the following modules to load on next shell invocation.
EOF
    for p in $DIR/bash_modules.d/*; do
        x=`basename $p`
        head=`egrep "^#[^!][ 	]*[^ 	]" $p | head -n1`
        echo >> $PREFIX/.bash_modules
        echo "$head" >> $PREFIX/.bash_modules
        echo "# $x" >> $PREFIX/.bash_modules
    done
fi
