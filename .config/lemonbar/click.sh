#!/bin/bash

while read -r line; do
		case $line in
				desktop-*)
						bspc desktop -f "${line#desktop-}"
						;;
				volumeUP)
						pactl set-sink-mute 0 false &
						pactl set-sink-volume 0 +1% &
						;;
				volumeDOWN)
						pactl set-sink-mute 0 false &
						pactl set-sink-volume 0 -1% &
						;;
				volume)
						pactl set-sink-mute 0 toggle
						;;
				*)
						echo "Can't process command '${line}'" >&2
						;;
		esac

done
