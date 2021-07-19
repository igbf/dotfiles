# Set the terminal title using OSC2 and precmd and preexec hooks
function title_precmd() {
	print -Pn -- '\e]2;%n@%m %~\a'
}

function title_preexec() {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
}

precmd_functions+=( title_precmd )
preexec_functions+=( title_preexec )
typeset -U precmd_functions
typeset -U preexec_functions
