#!/bin/sh
sudo xbps-install -S >/dev/null 2>&1
xbps_updates=$(sudo xbps-install -Sun | wc -l)
flatpak_updates=$(flatpak remote-ls --updates | wc -l)
# Notify the user if there are any updates
if [ "$xbps_updates" -gt 0 ] || [ "$flatpak_updates" -gt 0 ]; then
    notify-send -t 0 "System Updates" \
        "<b>Xbps:</b> $xbps_updates updates\n<b>Flatpak:</b> $flatpak_updates updates"
fi
