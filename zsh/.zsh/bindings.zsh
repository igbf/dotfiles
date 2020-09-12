# Autosuggest
bindkey '^f' autosuggest-accept
bindkey '^d' autosuggest-execute

# History
bindkey '^j' history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Completion
bindkey '^n' menu-expand-or-complete
bindkey '^p' reverse-menu-complete
bindkey "$(tput cbt)" reverse-menu-complete

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line
