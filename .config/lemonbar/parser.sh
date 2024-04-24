#!/bin/bash

set -x
cd $(dirname -- $0)

. ./common.sh

desktop="$(bspc_desktops)"
OLD_IFS=$IFS

while IFS=$'\n' read -r line; do
    IFS=$OLD_IFS
    case $line in
        DAT*)
            date="%{B${color_hl1}} ${CLOCK} ${line#???} %{B-}"
            ;;
        DES*)
            desktop="${line#???}"
            ;;
        BRI*)
            brightness="%{A4:brightnessUP:}%{A5:brightnessDOWN:} ${line#???}${BRIGHTNESS} %{A}%{A}"
            ;;
        VOL*)
            volume="%{A:volume:}%{A4:volumeUP:}%{A5:volumeDOWN:} ${line#???} %{A}%{A}%{A}"
            ;;
        BAT*)
            battery="${line#???}"
            ;;
        MPR*)
            mpris="${line#???} ${SPOTIFY} %{A:prevMpris:}${MPRIS_PREV}%{A} ${MPRIS_PLAY} %{A:nextMpris:}${MPRIS_NEXT}%{A}"
            ;;
        *)
            ;;
    esac

    echo -e "%{l}${date}${desktop}%{r} ${mpris} ${brightness} ${volume} ${battery} "
done
