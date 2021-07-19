# Unalias run-help from man to the zsh function of the same name which gives better help for shell builtin commands
unalias run-help
autoload -Uz run-help
alias help=run-help
