#! /usr/bin/env zsh
# Configuration for interactive Z shells
#

ZCACHEDIR=$XDG_CACHE_HOME/zsh
[[ ! -d $ZCACHEDIR ]] && mkdir $ZCACHEDIR

ZPLUGINDIR=$HOME/.zsh/plugins

#
# History
#
HISTSIZE=20000
SAVEHIST=15000
HISTFILE=$ZCACHEDIR/history

unsetopt append_history		# Append to history on shell exit
setopt share_history
setopt inc_append_history	# Append to history as soon as command finishes
setopt hist_ignore_space	# Do not commit lines beginning with space to history
setopt hist_ignore_dups		# Ignore contiguous dups
setopt hist_expire_dups_first	# Expire duplicates first when trimming history

#
# Completion
#
zmodload zsh/complist
fpath=($ZPLUGINDIR/zsh-completions/src ${fpath[@]})
autoload -Uz compinit
compinit -d $ZCACHEDIR/compdump

setopt complete_aliases		# Complete arguments for aliases
setopt always_to_end		# Move cursor to end of word after completion
setopt list_packed		# Vary column width

# Automatically rehash commands
zstyle ':completion:*' rehash true

# Cache completions
zstyle ':completion:*:complete:*' use-cache true
zstyle ':completion:*:complete:*' cache-path $ZCACHEDIR/compcache

# Make completion list easier to read
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS:-\'\'}
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{default}%B--- %d ---%b%f'
zstyle ':completion:*:warnings' format '%F{red}Sorry, no matches for: %d%f'

# Try exact completion first,
# then case-insensitive completion
zstyle ':completion:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

#
# Plugins
#
zmodload zsh/zpty
ZSH_AUTOSUGGEST=(history completion)
source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZPLUGINDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZPLUGINDIR/zsh-history-substring-search/zsh-history-substring-search.zsh

# CDR
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file $ZCACHEDIR/recent_dirs


# Autoload functions
fpath=($HOME/.zsh/functions ${fpath[@]})
autoload -Uz $HOME/.zsh/functions/*(.:t)

# Load other configuration files from ~/.zsh
for file in $HOME/.zsh/*(.N)
do
	source $file
done
