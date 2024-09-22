#!/bin/sh
pkill -x swaybg
swaybg -i $(find $HOME/pictures/walls/*.jpg -type f | shuf -n1) -m fill &
