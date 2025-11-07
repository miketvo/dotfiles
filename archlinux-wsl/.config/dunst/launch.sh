#!/usr/bin/env bash

# Terminate already running notification daemon
killall -q dunst

# Launch a new instance
dunst 2>&1 | tee -a /tmp/dunst.log & disown
