#!/usr/bin/env bash

if [ "$ROFI_RETV" = "0" ]; then
    # Initial call: provide options
    echo "Option 1"
    echo "Option 2"
    echo "Exit"
elif [ "$ROFI_RETV" = "1" ]; then
    # Entry selected
    case "$@" in
        "Option 1")
            notify-send "You selected Option 1!"
            ;;
        "Option 2")
            notify-send "You selected Option 2!"
            ;;
        "Exit")
            exit 0
            ;;
    esac
elif [ "$ROFI_RETV" = "2" ]; then
    # Custom entry
    notify-send "You entered: $@"
fi
