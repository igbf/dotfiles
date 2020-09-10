#! /usr/bin/env bash
# Simple volume notification
# Depends: pulsemixer, notify-send.sh, and progress.sh

volume=$(pulsemixer --get-volume | awk '{print $1}')

if $(pulsemixer --get-mute | grep 1 > /dev/null)
then
	icon=audio-volume-muted
else
	icon=audio-volume-high
fi

notify-send.sh --icon=${icon}\
	--app-name=pulsemixer --category=sysinfo \
	--replace-file=/tmp/volnoti \
	"$($HOME/bin/progress.sh ${volume} 100 15)  ${volume}"
