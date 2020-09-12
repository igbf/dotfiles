#! /usr/bin/env zsh
# Environment variables used by ZSH
# Loaded by all instances of ZSH
#


# PATH
typeset -U path PATH
path=($HOME/bin ${path[@]})
export PATH

# XDG Directories (see also $XDG_CONFIG_HOME/user-dirs.dirs)
XDG_CACHE_HOME=$HOME/.cache
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME

# Basic utilities
EDITOR=nvim
PAGER=less
VISUAL=nvim
export EDITOR PAGER VISUAL 
