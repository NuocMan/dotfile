#!/bin/bash

POLYBAR_DIR=~/.config/polybar

if [[ $1 == "-l" ]]; then
    ls $POLYBAR_DIR/themes
    exit 0
fi

if [[ -z $1
    || ! -x "$POLYBAR_DIR/themes/$1/launch.sh" ]]; then
    echo "'$1' theme doesn't exist"
    exit 1
fi

rm -f $(find "$POLYBAR_DIR" -type l)
ln -f -s -t "$POLYBAR_DIR" "$POLYBAR_DIR"/themes/$1/*
if [[ $2 == "-r" ]]; then
    $POLYBAR_DIR/launch.sh
fi
