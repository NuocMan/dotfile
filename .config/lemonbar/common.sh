#!/bin/bash

theme="spacemacs"

case $theme in
    spacemacs)
        color_bg="#353b45"
        color_fg="#abb2bf"
        color_hl1='#5d4d7a'
        color_hl2="#373040"
        ;;
    dracula)
        color_bg="#282a36"
        color_fg="#f8f8f2"
        color_hl1="#6272a4"
        color_hl2="#bd93f9"
        ;;
    *) # Default to Nord
        color_bg="#2e3440"
        color_fg="#eceff4"
        color_hl1="#5e81ac"
        color_hl2="#81a1c1"
        ;;
esac

VOL_LO="\uE9FA"
VOL_MI="\uE9FB"
VOL_HI="\uE9FC"
VOL_OFF="\uE9FD"

BAT_USE="\ue91c"
BAT_POW="\ue91d"

NW_OFF="\uea00"
NW_ON="\ue9ff"

BRIGHTNESS="\ue9d7"

CLOCK="\uE939"

DISK="\uE951"


bspc_desktops() {
    desktops=$(bspc query -D --names)
    buf=""
    for d in ${desktops[@]}; do
        if [[ "$(bspc query -D -d focused --names)" == "${d}" ]]; then
            buf="${buf} %{B${color_hl2}} %{A:desktop-${d}:} ${d} %{A} %{B-}"
        else
            buf="${buf}  %{A:desktop-${d}:} ${d} %{A} "
        fi
    done

    echo "${buf}"
}
