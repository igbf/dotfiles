
# Initialise Vi-like bindings
bindkey -v

# Shorten wait-time before switching modes to 1 second
KEYTIMEOUT=1
export KEYTIMEOUT

# Use cursor to indicate Vi-mode
function zle-keymap-select()
{
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]
	then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]
	then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

function zle-line-init()
{
	zle -K viins	# Start in vi insert mode
	echo -ne '\e[5 q'
}
zle -N zle-line-init

# More text objects like vi (https://github.com/zsh-users/zsh/blob/master/Functions/Zle/select-quoted)
# and https://github.com/zsh-users/zsh/blo/master/Functions/Zle/select-bracketed)
# Quoted (",',`) text objects
autoload -Uz select-quoted
zle -N select-quoted
for m in visual viopp
do
	for c in {a,i}{\',\",\`}
	do
		bindkey -M $m $c select-quoted
	done
done

# Bracketed ((),[],{},<>) text objects
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp
do
	for c in {a,i}${(s..)^:-'()[]{}<>bB'}
	do
		bindkey -M $m $c select-bracketed
	done
done

# Surround (https://github.com/zsh-users/zsh/blob/master/Functions/Zle/surround)
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

