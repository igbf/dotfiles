# Opening and editing files
alias edit='$EDITOR '
function open()
{
	xdg-open "$@" &!
}

# More colour
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Change directories using cdr
alias cd='cdr '
