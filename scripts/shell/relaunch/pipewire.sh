#!/bin/sh

for process in pipewire wireplumber pipewire-pulse; do
    pkill -x "$process"
done
sleep 1 
# Start PipeWire and related services
pipewire
sleep 1
wireplumber
pipewire-pulse
