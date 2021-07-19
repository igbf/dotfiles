#! /usr/bin/env zsh
# Text objects
autoload -U select-quoted
zle -N select-quoted
autoload -U select-bracketed
zle -N select-bracketed
local m seq
for m in vicmd viopp
do
	for seq in {a,i}{\',\",\`}
	do
		bindkey -M "$m" "$seq" select-quoted
	done

	for seq in {a,i}${(s..)^:-'()[]{}<>bB'}
	do
		bindkey -M "$m" "$seq" select-bracketed
	done
done

# Surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround

bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround
