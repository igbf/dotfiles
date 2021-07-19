#! /usr/bin/env zsh
# Configuration for interactive Z shells, sourced after .zshenv and .zprofile
# but before .zlogin

# Parameters ==================================================================
ZCACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "${ZCACHEDIR}" ]] || mkdir -p "${ZCACHEDIR}"


# History ================================================================={{{1
HISTFILE=$ZCACHEDIR/history
HISTSIZE=15000
SAVEHIST=10000

# Keep the following pattern out of HISTFILE
HISTORY_IGNORE="(fc *|clear)"

# Do not store the history command
setopt hist_no_store

# TODO: Consider if this is what we want history to behave like
# INFO: Test this after maybe a week, to see what history traversal looks like
# INFO: history -i 1- for timestamps and from first entry
# Append to rather than replace HISTFILE, but only do so on shell exit
# or manually using `fc -AI` to write and `fc -RI` to read
setopt append_history
setopt no_inc_append_history
setopt no_inc_append_history_time
setopt no_share_history

# Store extended information in history file
setopt extended_history

# Keep duplicates so old block of code are easier to follow
setopt no_hist_expire_dups_first
setopt no_hist_find_no_dups
setopt no_hist_ignore_all_dups
setopt hist_ignore_dups
setopt no_hist_save_no_dups

# Do not commit lines beginning with a space to history
setopt hist_ignore_space

# Remove syntactically unimportant blanks before commiting to history list
setopt hist_reduce_blanks

# Confirm when performing history expansion
setopt hist_verify

# Hook function to keep lines matching HISTORY_IGNORE out of internal history
zsh_history_ignore() {
	emulate -L zsh
	#setopt extended_glob
	
	# Remove the trailing new line from the argument
	[[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

# Register zshaddhistory hook functions
zshaddhistory_functions+=( zsh_history_ignore )
typeset -U zshaddhistory_functions

# End of History 1}}}

# Changing Directories ===================================================={{{1
# CD if a command is issued that can't be resolve as command but is the name of a directory
setopt auto_cd

# Have cd push to the directory stack
setopt auto_pushd

# TODO: Decide if we want this
# Resolve symbolic links to their true values when cd'ing
setopt chase_links

# Do not push duplicates to the directory stack
setopt pushd_ignore_dups

# Do print the directory stack after a pushd or popd
setopt no_pushd_silent

# pushd without args acts like pushd $HOME
setopt pushd_to_home

# End of Changing Directories 1}}}

# Completion =============================================================={{{1
# TODO: Figure out how these settings interact with the compsys system
# Move the cursor to the end of the word if a complete completion is inserted.
setopt always_to_end
setopt no_complete_in_word

# List choices on ambiguous completion
setopt auto_list

# Automatically end pathname completions with a trailing slash, and remove it smartly
setopt auto_param_slash
setopt auto_remove_slash

# TODO: Not sure if we need this, test once we have flag completion set up
# setopt complete_aliases

# TODO: Test behaviour when completing a glob pattern
# setopt glob_complete

# Use dynamic column widths
setopt list_packed

# When listing filename completions indicate their type with a trailing character.
setopt list_types

# Do not immediately insert the first match, instead do so on the second time Tab is hit
setopt no_menu_complete
setopt auto_menu

# End of Completion 1}}}

# Expansion and Globbing =================================================={{{1
# TODO: Test commented options

# ~, #, ^ are special when globbing without escaping
setopt extended_glob

# Perform filename generation/expansion on expanded parameters
# setopt glob_subst

# Use regex matching rather than string matching when substituting in history expansion
# setopt hist_subst_pattern

# Sort filenames numerically
setopt numeric_glob_sort

# End of Expansion and Globbing 1}}}

# Input/Output ============================================================{{{1
# Expand aliases
setopt aliases

# TODO: Test whether I like this or not
# Try to correct the spelling of commands and arguments
# Filenames not be offered may be set as pattern in $CORRECT_IGNORE
setopt correct
setopt correct_all

# Allow comments in an interactive shell
setopt interactive_comments

# Query for confirmation before executing rm *
setopt no_rm_star_silent
# End of Input/Output 1}}}

# Job control ============================================================={{{1
# Send SIGCONT to stopped jobs when they are disowned
setopt auto_continue

# Run background jobs at lower priority
setopt bg_nice

# Report the status of background jobs only when a new prompt is drawn
setopt no_notify

# End of Job control 1}}}

# Prompting ==============================================================={{{1
# Allow parameter , command, and arithmetic expansion in prompts
setopt prompt_subst

# End of Prompting 1}}}

# Autoload functions
fpath=($HOME/.zsh/functions ${fpath[@]})
[[ -n $HOME/.zsh/functions/*(#qN) ]] && \
    autoload -Uz $HOME/.zsh/functions/*(.:t)

# Plugins {{{1
ZPLUGINDIR=$HOME/.zsh/plugins
[[ -f $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
	source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f $ZPLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
	source $ZPLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f $ZPLUGINDIR/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
	source $ZPLUGINDIR/zsh-history-substring-search/zsh-history-substring-search.zsh

# FZF
#FZF_DEFAULT_OPTS
#FZF_SELECT_FILES_OPTS
#FZF_CD_OPTS
#FZF_HISTORY_OPTS
#FZF_HEIGHT
function fzf_history() {
	local event=($(history -di | FZF_DEFAULT_OPTS="--height ${FZF_HEIGHT:-40%} ${FZF_DEFAULT_OPTS} -n4.. --tac --tiebreak=index --bind=ctrl-z:ignore --query=${LBUFFER} --no-multi" fzf ${FZF_HISTORY_OPTS}))
	local ret=$?
	if [[ -n "${event}" ]]
	then
		local num=$event[1]
		if [[ -n "${num}" ]]
		then
			zle vi-fetch-history -n ${num}
		fi
	fi
	zle reset-prompt
	return ${ret}
}
zle -N fzf_history
bindkey '^R' fzf_history

function fzf_select_file() {
	local cmd="${FZF_SELECT_FILES_CMD:-"rg --files --hidden --follow 2>/dev/null"}"
	local file="$(eval "${cmd}" | FZF_DEFAULT_OPTS="--height ${FZF_HEIGHT:-40%} --tac --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS} --multi" fzf ${FZF_SELECT_FILES_OPTS})"
	local ret=$?
	LBUFFER="${LBUFFER}${file}"
	zle reset-prompt
	return ${ret}
}
zle -N fzf_select_file
bindkey '^T' fzf_select_file

function fzf_cd() {
	local cmd="${FZF_CD_CMD:-"rg --files --hidden --follow --null 2>/dev/null | xargs -0 dirname | uniq"}"
	local dir="$(eval "${cmd}" | FZF_DEFAULT_OPTS="--height ${FZF_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS}" fzf ${FZF_CD_OPTS} --no-multi)"
	if [[ -z "${dir}" ]]
	then
		zle redisplay
		return 0
	fi
	zle push-line
	BUFFER="cd ${(q)dir}"  #"
	zle accept-line
	local ret=$?
	unset dir
	zle reset-prompt
	return $ret
}
zle -N fzf_cd
bindkey '\ec' fzf_cd

# Required for the completion suggestion strategy
zmodload zsh/zpty
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# 1}}}

# Source additional configuration files
for file in $HOME/.zsh/config/<00-10>-*(.n)
do
	source "${file}"
done

# Source aliases
source ~/.zsh/aliases.zsh

# vim: set foldmethod=marker foldlevelstart=0:
