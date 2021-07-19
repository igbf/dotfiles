#! /usr/bin/env zsh
# $HOME/.zshenv is sourced first (but after the system file /etc/zshenv) for all invocations of the Z shell, be they interactive or not, or login shells or not.
# I use it to set environment variables that I expect to be available everywhere

# PATH
typeset -U path PATH
test -d "${HOME}/.local/bin}" && path=("${HOME}/.local/bin" ${path[@]})
test -d "${HOME/scripts}" && path=("${HOME}/scripts" ${path[@]})
test -d "${HOME/bin}" && path=("${HOME}/bin" ${path[@]})
GOPATH=~/.local/bin/go
export PATH GOPATH

# XDG Directories (see also $XDG_CONFIG_HOME/user-dirs.dirs)
XDG_CACHE_HOME=$HOME/.cache
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME

# Basic utilities
BROWSER=firefox
EDITOR=nvim
PAGER=less
VISUAL=nvim
MANPAGER='nvim +Man!'
export BROWSER EDITOR PAGER VISUAL MANPAGER
