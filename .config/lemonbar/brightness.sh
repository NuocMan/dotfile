#!/bin/bash

. ./common.sh

if [[ -z "$1" || ! -e "$1" ]]; then
		echo "$0: Give a file as first parameter" >&2
		exit 1
fi

while :; do
    echo "BRI$(xbacklight -get | cut -d'.' -f1)%" > "$1"
    sleep 0.5
done
