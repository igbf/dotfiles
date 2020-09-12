#! /usr/bin/env zsh
# Executed by Login shells
if [[ $(tty) = /dev/tty1 ]]
then
	exec sway
fi
