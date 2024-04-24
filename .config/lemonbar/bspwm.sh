#!/bin/bash

. ./common.sh

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

bspc subscribe desktop | while read -r line; do
    echo "DES$(bspc_desktops)"
done
