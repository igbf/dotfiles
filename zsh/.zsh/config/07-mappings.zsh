# Mappings for ZSH
#
#
# bindkey "^Og" noglob-command-line
# bindkey "^Os" sudo-command-line
# bindkey "^Ol" less-command-line
# bindkey "^OL" less-command-line-output
# bindkey "^Oh" sub-command-line

# Autosuggest
bindkey '^f' autosuggest-accept
bindkey '^d' autosuggest-execute

# History
bindkey $key[Up] history-substring-search-up
bindkey $key[Down] history-substring-search-down

bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Completion
bindkey '^n' menu-expand-or-complete		# Try to expand variables, history, commands, etc.
bindkey '^p' reverse-menu-complete
bindkey "$(tput cbt)" reverse-menu-complete
bindkey '\C-z' undo							# Undo expansion see man zshle(1)

# Edit command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# Command line navigation
bindkey ${key[Home]} beginning-of-line
bindkey ${key[End]} end-of-line
bindkey -M vicmd ${key[Home]} beginning-of-line
bindkey -M vicmd ${key[End]} end-of-line
bindkey ${key[Insert]} overwrite-mode
bindkey ${key[Delete]} delete-char

bindkey ' ' magic-space


# Completion list mode
bindkey -M listscroll q send-break
