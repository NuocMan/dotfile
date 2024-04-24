#!/bin/bash

. ./common.sh

while :; do
    ret_bat=$(acpi --battery)
    bat_percent=$(echo "$ret_bat" | cut -d, -f2 | tr -d " ")
    bat_state=$(echo "$ret_bat" | cut -d, -f1)

    if [[ $bat_state =~ .*Discharging ]]; then
        index=$(( ${bat_percent::-1} / 10 ))
        bat_icon=${BAT_PERC[$index]}
    else
        bat_icon=${BAT_POW}
    fi

    echo -e "BAT${bat_percent}${bat_icon}"
    sleep 10
done
