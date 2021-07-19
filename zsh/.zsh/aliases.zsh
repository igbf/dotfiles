#! /usr/bin/env sh
# Add colours to commands
alias grep='grep --color=auto'
alias ip='ip -color'

# LS
alias ls='ls --color=auto'
alias la='ls -lha'
alias ll='ls -lh'

# Editing, opening, and viewing files
alias edit='$EDITOR '

# Traverse to upper directories quicker
alias -g ...='../..'

# Allow alias expansion when usign sudo
alias sudo='sudo '

# gitroot
alias gitroot='cd $(git rev-parse --show-toplevel)'

# help
autoload -Uz run-help && alias help="run-help"
