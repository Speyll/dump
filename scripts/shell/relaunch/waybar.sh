#!/bin/sh

pkill -x waybar

WAYBAR_MODE="stacking"

case "$WAYBAR_MODE" in
    stacking)
        pkill -x waybar; waybar -c "$HOME/.config/waybar/stacking-config" -s "$HOME/.config/waybar/style.css" >/dev/null 2>&1 &
        ;;
    tiling)
        pkill -x waybar; waybar -c "$HOME/.config/waybar/tiling-config" -s "$HOME/.config/waybar/style.css" >/dev/null 2>&1 &
        ;;
    none) ;;
esac
