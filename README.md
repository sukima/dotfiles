# Dotty repository

Dotfiles for Sukima (suki@tritarget.org). Includes:

- bash
- git
- elinks
- screen
- tmux

## dotfiles/

Dotty will symlink files and directories in the root your repos dotfiles/ directory, relative to ~.
You can symlink stuff to sub directories of ~ by using the in+subdir directory naming convention.

### Examples

    dotfiles/.vim             => ~/.vim
    dotfiles/in+.ssh/config   => ~/.ssh/config
    dotfiles/in+a/in+b/c      => ~/a/b/c

## dotty-symlink.yml

If you want more control over the symlinking, you can create a dotty-symlink.yml in the repo root.

### Example
    
    file_in_repo:.in_home_dir

## dotty-repository.thor

If you want to do more than symlinking, you can create a dotty-repository.thor that implements the 'bootstrap' and 'implode' thor tasks.
The class must be named "DottyRepository".

### Example

    class DottyRepository < Thor
      include Thor::Actions

      desc "bootstrap", "Bootstrap this repo"
      def bootstrap
        # Do stuff here
      end

      desc "implode", "Implode this repo"
      def implode
        # Do stuff here
      end
    end
