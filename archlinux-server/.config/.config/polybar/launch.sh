#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
killall -q polybar

# Launch a new instance
polybar status 2>&1 | tee -a /tmp/polybar.log & disown
