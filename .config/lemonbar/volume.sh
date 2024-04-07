#!/bin/bash

. ./common.sh

if [[ -z "$1" || ! -e "$1" ]]; then
    echo "$0: Give a file as first parameter" >&2
    exit 1
fi

while :; do
    current=$(pactl list sinks | awk '/\tVolume/ {print $5}')
    current_n=$(cut -d'%' -f1 <<< $current)

    if [[ "$(pactl list sinks | awk '/Mute:/ {print $2}')" == "yes" ]]; then
        icon="${VOL_OFF}"
    elif (( current_n > 50 )); then
        icon="${VOL_HI}"
    elif (( current_n > 25 )); then
        icon="${VOL_MI}"
    else
        icon="${VOL_LO}"
    fi

    echo "VOL${icon} ${current}" > "$1"

    sleep 0.5
done
