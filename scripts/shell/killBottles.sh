#!/bin/bash

# Define the Flatpak application name
APP_NAME="bottles"

# Find and kill bwarp processes associated with the specified Flatpak application
bwarp_pids=$(pgrep -f "$APP_NAME")

if [ -n "$bwarp_pids" ]; then
    echo "Killing bwarp processes for $APP_NAME..."
    for pid in $bwarp_pids; do
        kill -9 "$pid"
    done
else
    echo "No bwarp processes found for $APP_NAME"
fi

