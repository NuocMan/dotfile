#!/bin/bash

. ./common.sh

if [[ -z "$1" || ! -e "$1" ]]; then
    echo "$0: Give a file as first parameter" >&2
    exit 1
fi

while read -r line; do
    echo "MPR$(mpris_metadata)" > "$1"
done < <(dbus-monitor --session --profile "path=/org/mpris/MediaPlayer2,interface=org.freedesktop.DBus.Properties,member=PropertiesChanged")
