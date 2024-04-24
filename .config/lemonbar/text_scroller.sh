#!/bin/bash

if (( $# < 2 )); then
    echo "$0: str; size" >&2
    exit 1
fi

str=$1; shift
size=$1; shift
offset=0

if (( size < ${#str} )); then
    while :; do
        banner="$str - "
        banner="${banner:$offset}${banner:0:$offset}"
        offset=$(( (offset + 1) % ${#banner} ))
        echo "MPR${banner:0:$size}"
        sleep 1
    done
else
    blank_nb=$(( size - ${#str} ))
    if (( blank_nb > 0 )); then
        blank=$(printf ' %.0s' $(seq $blank_nb))
    fi
    sleep 1
    echo "MPR${blank}${str:0:$size}"
fi
