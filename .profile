# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
# what is defined here is also available for applications started from
# GNOME menus, and not only for applications started from the command line
if [ -d "$HOME/dotnet" ] ; then
    DOTNET_ROOT=$HOME/dotnet
    PATH="$PATH:$HOME/dotnet"
fi

# jat, 2019-01-19
export EDITOR=$(which vim)

# jat, 2020-08-18
if [ -f ~/.bash_paths.local ]; then
    . ~/.bash_paths.local
fi

#
# Config dir
#
export XDG_CONFIG_HOME=$(xdg-user-dir CONFIG)

#
# nvm: node version manager
# 
if [ -d "${XDG_CONFIG_HOME}/nvm" ] ; then
    export NVM_DIR=${XDG_CONFIG_HOME}/nvm
    source ${NVM_DIR}/nvm.sh
    source ${NVM_DIR}/bash_completion
    nvm use node

    #
    # yarn
    #
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
