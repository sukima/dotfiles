# Dotty repository

Dotfiles for Sukima (suki@tritarget.org). Includes:

- bash
- git
- elinks
- screen
- tmux

Files and directories that already exists while installing with dotty will
cause it to fail. After you fix the offending directories to can pick up where
you left off again with the `dotty bootstrap <name>` command where `<name>` is
the name of the failed repository you tried to install.

## dotfiles/

Dotty will symlink files and directories in the root your repos dotfiles/ directory, relative to ~.
You can symlink stuff to sub directories of ~ by using the in+subdir directory naming convention.

More information available at http://github.com/trym/dotty#readme

### Examples

    dotfiles/.vim             => ~/.vim
    dotfiles/in+.ssh/config   => ~/.ssh/config
    dotfiles/in+a/in+b/c      => ~/a/b/c

## Non dotty users

A simple `install.sh` file is included which you can use to symlink the config files.

    Usage: install.sh [-h][-I][-f] [-d prefix]
      -I,--no-install           Do not install symlinks (.bashrc, etc)
      -f,--force                Force overwriting bashrc, etc. ** DESTRUCTIVE **
      -h,--help                 This cruft
      -d,--dir prefix           Install to prefix instead of default $HOME
    Cannot concatinate arguments (-If will not work, use -I -f instead).

## bash_modules

The `.bash_modules` file lists modules to run on each invocation of a new
shell. These are modules that are not neccissary for a default shell but add or
enhance the environment. (for example competions and custom prompts or
universal aliases)

The file ignores any line that is commented with a # (hash mark) and any non
black line is a name of a module you would like to load.

All modules are found in the `.bash_modules.d` folder.
