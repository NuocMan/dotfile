#!/bin/bash

. ./common.sh

if [[ -z "$1" || ! -e "$1" ]]; then
    echo "$0: Give a file as first parameter" >&2
    exit 1
fi

trap 'kill $(jobs -p)' EXIT

while read -r line; do
    echo "DES$(bspc_desktops)" > "$1"
done < <(bspc subscribe desktop)
