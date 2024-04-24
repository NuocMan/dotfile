#!/bin/bash

. ./common.sh

while :; do
    current=$(pactl list sinks | awk '/\tVolume/ {print $5}')
    current_n=$(cut -d'%' -f1 <<< $current)

    if [[ "$(pactl list sinks | awk '/Mute:/ {print $2}')" == "yes" ]] || (( current_n == 0 )); then
        icon="${VOL_OFF}"
    elif (( current_n < 33 )); then
        icon="${VOL_LO}"
    elif (( current_n < 66 )); then
        icon="${VOL_MI}"
    else
        icon="${VOL_HI}"
    fi

    echo -e "VOL${current}${icon}"

    sleep 0.5
done
