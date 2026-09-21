#!/usr/bin/env bash

if [ "$@" ]; then
    exit 0
fi
cat $HOME/.desktop_keybinds.txt
