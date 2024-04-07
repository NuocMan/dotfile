#!/bin/bash

. ./common.sh

if [[ -z "$1" || ! -e "$1" ]]; then
    echo "$0: Give a file as first parameter" >&2
    exit 1
fi

while :; do
    date "+DAT%a %d %b, %T" > "$1"
    sleep 1
done
