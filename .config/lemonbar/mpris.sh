#!/bin/bash

. ./common.sh

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

dbus-monitor --session \
             --profile "path=/org/mpris/MediaPlayer2,interface=org.freedesktop.DBus.Properties,member=PropertiesChanged" \
    | while read -r line; do

    [[ -n $PID ]] && kill "$PID"
    mpris_md=$(mpris_metadata)
    readarray -td';' mpris_array < <(printf '%s' "$mpris_md")

    ./text_scroller.sh "${mpris_array[2]} - ${mpris_array[0]}" 25 &
    PID=$!
done

[[ -n $PID ]] && kill "$PID"
