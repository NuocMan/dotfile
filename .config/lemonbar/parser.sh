#!/bin/bash

set -e
cd $(dirname -- $0)

. ./common.sh

desktop="$(bspc_desktops)"
mpris_metadata="$(mpris_metadata)"
while read -r line; do
    case $line in
        DAT*)
            date="%{B${color_hl1}} ${CLOCK} ${line#???}   %{B-}"
            ;;
        DES*)
            desktop="${line#???}"
            ;;
        BRI*)
            brightness="%{A4:brightnessUP:}%{A5:brightnessDOWN:} ${BRIGHTNESS} ${line#???} %{A}%{A}"
            ;;
        VOL*)
            volume="%{A:volume:}%{A4:volumeUP:}%{A5:volumeDOWN:} ${line#???} %{A}%{A}%{A}"
            ;;
        BAT*)
            battery="${line#???}"
            ;;
        MPR*)
            mpris_metadata="${line#???}"
            readarray -td';' mpris_array < <(printf '%s' "$mpris_metadata")
            mpris="%{A:prevMpris:}${MPRIS_PREV}%{A} ${MPRIS_PLAY} %{A:nextMpris:}${MPRIS_NEXT}%{A} ${mpris_array[2]} - ${mpris_array[0]}"
            ;;
        *)
            ;;
    esac

    echo -e "%{l}${date}${desktop}%{r} ${mpris} ${brightness}  ${volume} ${battery}    "
done
