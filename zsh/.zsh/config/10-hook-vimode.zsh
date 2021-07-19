# Use the cursor shape to indicate the mode
declare -A cursorshapes
cursorshapes=([blinkblock]=1 [block]=2 [blinkunderline]=3 [underline]=4 [blinkbeam]=5 [beam]=6)

function _vi-mode-set_indicator() {
	local _shape=0
	printf $'\e[%d q'
	case ${1:-${KEYMAP}} in
		main) _shape=${cursorshapes[beam]};;
		viins) _shape=${cursorshapes[beam]};;
		isearch) _shape=${cursorshapes[beam]};;
		command) _shape=${cursorshapes[beam]};;
		vicmd) _shape=${cursorshapes[block]};;
		visual) _shape=${cursorshapes[block]};;
		viopp) _shape=${cursorshapes[blinkblock]};;
		*) _shape=0
	esac
	printf $'\e[%d q' "${_shape}"
}

function zle-keymap-select() {
	_vi-mode-set_indicator "${KEYMAP}"
}
zle -N zle-keymap-select

function zle-line-init() {
	(( ! ${+terminfo[smkx]} )) || echoti smkx
	_vi-mode-set_indicator "${KEYMAP}"
}
zle -N zle-line-init

function zle-line-finish() {
	(( ! ${+terminfo[rmkx]} )) || echoti rmkx
	_vi-mode-set_indicator default
}
zle -N zle-line-finish
