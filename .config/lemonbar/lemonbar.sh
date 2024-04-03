#!/bin/bash

cd $(dirname -- $0)

export PATH="$PWD:$PATH"
. ./common.sh

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo
[[ ! -e $fifo ]] && mkfifo $fifo

trap 'kill $(jobs -p)' EXIT

# Date
date.sh "$fifo" &

# BSPWM desktops
bspwm.sh "$fifo" &

# Brightness
brightness.sh "$fifo" &

# Volume
volume.sh "$fifo" &

# Battery
battery.sh "$fifo" &

WIDTH=
HEIGHT=30
XOFFSET=0
YOFFSET=0

tail -f $fifo | parser.sh | lemonbar \
	-p \
	-g "${WIDTH}x${HEIGHT}+${XOFFSET}+${YOFFSET}" \
	-B "${color_bg}" \
	-F "${color_fg}" \
 	-f 'icomoon\-feather:style=Regular' \
	-f "Roboto Mono,Roboto Mono Medium:style=Medium,Regular" \
	-a 100 | click.sh

