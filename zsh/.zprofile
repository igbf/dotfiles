#! /usr/bin/env zsh
# $HOME/.zprofile is sourced on login after sourcing .zshenv and before .zshrc (for interactive shells)
# Another candidate for starting sway is .zlogin which is sourced after .zshrc

# Start the sway compositor if running on /dev/tty1
if [[ $(tty) = /dev/tty1 ]]
then
	test $(command -v sway) && exec sway
fi
