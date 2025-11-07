#!/usr/bin/env bash

i3-msg -t subscribe -m '["workspace"]' | while read -r event; do
    event_type=$(echo "$event" | jq -r '.change')
    workspace=$(echo "$event" | jq -r '.current.name')
    if [ "$event_type" = "focus" ]; then
        twmnc -t " Workspace $workspace " -d 1000 --id 80
    fi
done
