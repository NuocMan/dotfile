#!/bin/bash

cd $(dirname -- $0)

export PATH="$PWD:$PATH"
. ./common.sh

#fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo
fifo=$(mktemp -u)
#[[ ! -e $fifo ]] && mkfifo $fifo
mkfifo "$fifo"

trap "trap - SIGTERM && kill -- -$$; rm -f \"$fifo\"" SIGINT SIGTERM EXIT

# Date
date.sh >> "$fifo" &

# BSPWM desktops
bspwm.sh >> "$fifo" &

# Brightness
brightness.sh >> "$fifo" &

# Volume
volume.sh >> "$fifo" &

# Battery
battery.sh >> "$fifo" &

# MPRIS
mpris.sh >> "$fifo" &

WIDTH=
HEIGHT=30
XOFFSET=0
YOFFSET=0

cat "$fifo" \
    | parser.sh \
    | lemonbar \
          -g "${WIDTH}x${HEIGHT}+${XOFFSET}+${YOFFSET}" \
          -B "${color_bg}" \
          -F "${color_fg}" \
          -f "Symbols Nerd Font Mono" \
          -f "Roboto Mono" \
          -f "Noto Sans Mono CJK JP" \
          -a 100 | click.sh

rm -f "$fifo"
