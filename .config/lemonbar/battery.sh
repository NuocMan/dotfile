#!/bin/bash

. ./common.sh

if [[ -z "$1" || ! -e "$1" ]]; then
    echo "$0: Give a file as first parameter" >&2
    exit 1
fi

while :; do
    ret_bat=$(acpi --battery)
    bat_percent=$(echo "$ret_bat" | cut -d, -f2)
    bat_state=$(echo "$ret_bat" | cut -d, -f1)

    if [[ $bat_state =~ .*Discharging ]]; then
        index=$(( ${bat_percent::-1} / 10 ))
        bat_icon=${BAT_PERC[$index]}
    else
        bat_icon=${BAT_POW}
    fi

    echo "BAT${bat_icon} ${bat_percent}" > "$1"
    sleep 10
done
