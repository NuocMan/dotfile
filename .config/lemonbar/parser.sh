#!/bin/bash

set -e
cd $(dirname -- $0)

. ./common.sh

desktop="$(bspc_desktops)"

while read -r line; do
    case $line in
        DAT*)
            date="%{B${color_hl1}} ${CLOCK} ${line#???}   %{B-}"
            ;;
        DES*)
            desktop="${line#???}"
            ;;
        BRI*)
            brightness="${BRIGHTNESS} ${line#???}"
            ;;
        VOL*)
            volume="${line#???}"
            ;;
        BAT*)
            battery="${line#???}"
            ;;
        *)
						;;
    esac

    echo -e "%{l}${date}${desktop}%{r} %{A4:brightnessUP:}%{A5:brightnessDOWN:} ${brightness} %{A}%{A}  %{A:volume:}%{A4:volumeUP:}%{A5:volumeDOWN:} ${volume} %{A}%{A}%{A} ${battery}    "
done
