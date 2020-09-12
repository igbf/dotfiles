#! /usr/bin/env zsh
#
setopt PROMPT_SUBST

autoload -Uz colors && colors

function _gitdir()
{
	# Check whether the current directory is part of a git repo.
	if $(git rev-parse --is-inside-work-tree 2>/dev/null )
	then
		local _root=$(git rev-parse --show-toplevel)
		local _branch=$(git branch --show-current)
		local _prefix=$(git rev-parse --show-prefix)

		# Check whether the head is detached
		if [[ -n ${_branch} ]]
		then
			# Check for dirty (also untracked) tree
			if [[ -n $(git status -s) ]]
			then
				_branch="%F{yellow}${_branch}%f"
			else
				_branch="%F{green}${_branch}%f"
			fi
		else
			_branch="%F{red}$(git show -s --oneline | awk '{print $1}')%f"
		fi
		print ${(D)_root}@${_branch} ${_prefix}
	else
		print "%~"
	fi
}


PROMPT='${SSH_CONNECTION:+%B%m%b}%(?.. %?) %B%(!.%F{red}.%F{yellow})%#%f%b '
RPROMPT='$(_gitdir)'
