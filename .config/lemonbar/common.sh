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

VOL_LO="\Uf057f"
VOL_MI="\Uf0580"
VOL_HI="\Uf1120"
VOL_OFF="\Uf075f"

BAT_CRIT="\Uf0083"
BAT_10="\Uf007a"
BAT_20="\Uf007b"
BAT_30="\Uf007c"
BAT_40="\Uf007d"
BAT_50="\Uf007e"
BAT_60="\Uf007f"
BAT_70="\Uf0080"
BAT_80="\Uf0081"
BAT_90="\Uf0082"
BAT_FULL="\Uf007a"
BAT_PERC=($BAT_CRIT $BAT_10 $BAT_20 $BAT_30 $BAT_40 $BAT_50 $BAT_60 $BAT_70 $BAT_80 $BAT_90 $BAT_FULL)
BAT_POW="\Uf0084"

BRIGHTNESS="\Uf00df"

CLOCK="\Uf0150"

MPRIS_PREV="\Uf0f28"
MPRIS_PLAY="\Uf0f1b"
MPRIS_PAUSE="\Uf03e4"
MPRIS_NEXT="\Uf0f27"

function bspc_desktops() {
    local desktops=$(bspc query -D --names)
    local buf=""
    for d in ${desktops[@]}; do
        if [[ "$(bspc query -D -d focused --names)" == "${d}" ]]; then
            buf="${buf} %{B${color_hl2}} %{A:desktop-${d}:} ${d} %{A} %{B-}"
        else
            buf="${buf}  %{A:desktop-${d}:} ${d} %{A} "
        fi
    done

    echo "${buf}"
}

TRACK_ID=trackid
LENGTH=length
ART_URL=artUrl
ALBUM=album
ALBUM_ARTIST=albumArtist
ARTIST=artist
AUTO_RATING=autoRating
DISC_NUMBER=discNumber
TITLE=title
TRACK_NUMBER=trackNumber
URL=url

function mpris_metadata() {
    local -A metadata
    while read -r line; do
        [[ ! "$line" =~ ^spotify\ .*$ ]] && continue
        line=${line#*\:}
        metadata[${line%% *}]=${line##*  } #might be a bit stupid
    done < <(playerctl metadata)

    echo "${metadata[${TITLE}]};${metadata[${ALBUM}]};${metadata[${ARTIST}]}"
}
