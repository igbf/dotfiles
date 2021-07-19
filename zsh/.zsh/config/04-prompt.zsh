# Prompt for Z shell along with some accompanying functions


_prompt_git_dir() {
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
			if [[ -n $(git status --porcelain) ]]
			then
				_branch="%F{yellow}${_branch}%f"
			else
				_branch="%F{green}${_branch}%f"
			fi
		else
			_branch="%F{red}$(git show -s --oneline | awk '{print $1}')%f"
		fi

		# ${(D)variable} assumes the string or array elements contain directories and attempt to substitute the leading part of these by names.  This is the reverse of ~ substitution
		# See also `parameter expansion flags` in zshexpn
		print ${(D)_root}@${_branch} ${_prefix}
	else
		print "%~"
	fi
}

_prompt_whoami() {
	local me=''
	if [[ -n ${SSH_CONNECTION} ]]; then
		me="%n@%m"
	elif [[ $LOGNAME != $USER ]]; then
		me = "%n"
	fi
	echo $me
}

# Primary prompt
# Show job and host indication on left hand side,
# show directory and git information on the right hand side.
PS1='%(1j.%j.)$(_prompt_whoami) %(?.%F{yellow}.%F{red})%(!.#.%%)%f '
RPS1='$(_prompt_git_dir)'

# Continuation prompt
# Show the current shell constructs (reversed in right-hand prompt)
PS2='%_> '
RPS2='<%^'

# Spelling suggestion prompt
#PS3='?#'

# Debugging prompt
#PS4='+%N:%i>'
