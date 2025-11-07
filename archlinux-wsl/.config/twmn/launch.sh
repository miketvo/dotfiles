#!/usr/bin/env bash

# Terminate already running notification daemons
killall -q twmnd

# Launch a new instance
twmnd 2>&1 | tee -a /tmp/polybar.log & disown
