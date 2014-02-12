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

## Appendix

### Mac OS X

- Solarized color theme for [Mac Terminal.app][1]

### Z-Modem support (iTerm2)

This script can be used to automate ZModem transfers from your OSX desktop to a
server that can run lrzsz (in theory, any machine that supports SSH), and
vice-versa.

The minimum supported iTerm2 version is 1.0.0.20120108

Setup is pretty simple:

1. `brew install lrzsz`
2. Set up Triggers in iTerm 2 like so:

    Regular expression: \*\*B0100
    Action: Run Silent Coprocess
    Parameters: /Users/suki/.dotty/default/dotfiles/bin/iterm2-send-zmodem.sh

    Regular expression: \*\*B00000000000000
    Action: Run Silent Coprocess
    Parameters: /Users/suki/.dotty/default/dotfiles/bin/iterm2-recv-zmodem.sh

To send a file to a remote machine:

1. Type "rz" on the remote machine
2. Select the file(s) on the local machine to send
3. Wait for the coprocess indicator to disappear

The receive a file from a remote machine

1. Type "sz filename1 filename2 … filenameN" on the remote machine
2. Select the folder to receive to on the local machine
3. Wait for the coprocess indicator to disappear

Future plans (patches welcome)

 - Visual progress bar indicator

### CA Certificates

To rebuild the `.certs/ca-bundle.crt` file follow the following:

1. Download latest cURL dist from http://curl.haxx.se/download/
2. Uncompress it in a tmp dir
3. cd to the distro’s lib directory
4. Run `./mk-ca-bundle.pl`
5. Copy the resulting `ca-bundle.crt` file to a convenient location.
   I put mine in `~/.dotty/default/dotfiles/dotfiles/.certs/ca-bundle.crt`

Or use `brew install curl-ca-bundle` also available when installing msmtp:
`brew install msmtp --with-curl-ca-bundle`. Then add the following to your
`~/.bash_local`:

    export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

And link it:

    $ ln -s /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt ~/.certs/ca-bundle.crt

1[]: https://github.com/tomislav/osx-lion-terminal.app-colors-solarized
