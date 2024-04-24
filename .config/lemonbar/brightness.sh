#!/bin/bash

. ./common.sh

while :; do
    echo "BRI$(xbacklight -get | cut -d'.' -f1)%"
    sleep 0.5
done
