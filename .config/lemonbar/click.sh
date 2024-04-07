#!/bin/bash

brightnessUPCounter=0
brightnessDOWNCounter=0

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
        brightnessUP)
            if (( brightnessUPCounter++ > 5 )); then
                xbacklight -inc 10
                brightnessUPCounter=0
            fi
            brightnessDOWNCounter=0
            ;;
        brightnessDOWN)
            if (( brightnessDOWNCounter++ > 5 )); then
		        # Avoid to set backlight to 0
		        if (( $(xbacklight -get) > 10  )); then
			        xbacklight -dec 10
		        fi
		        brightnessDOWNCounter=0
            fi
            brightnessUPCounter=0
            ;;
        desktopUP)
            bspc desktop -f "$(bspc query -D -d next)"
            ;;
        desktopDOWN)
            bspc desktop -f "$(bspc query -D -d prev)"
            ;;
        nextMpris)
            playerctl next
            ;;
        prevMpris)
            playerctl previous
            ;;
        *)
            echo "Can't process command '${line}'" >&2
            ;;
    esac

done
