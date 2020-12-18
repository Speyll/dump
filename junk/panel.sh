#!/bin/sh

# a="%{F#88C0D0}"
# t="%{F-}"

# Get your private IP
privip (){
	ip addr show | grep wl | awk '/inet/ {print $2}'
}

# Memory management
memory (){
	free -h | awk '/Mem/ {print $2}'
}

# Hard drive free space.
drive (){
	df -h | grep '/$' | awk '{print $5}'
}

# CPU temp.
cpu_temp (){
	sensors | awk '/Core 0/ {print $3}'
}

# Mixer volume level
volume (){
	awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master)
}

# Show the time and date
print_date (){
	date -u
}

while true
do
	BAR_INPUT="%{l}?$(cpu_temp) ?$(memory) ?$(drive) %{c}%{r}$(privip) ?$(volume)% ?$(print_date)"
	echo $BAR_INPUT
	sleep 1
done

#lemonbar -g x20 -o -1 -f "Cozette:size=9" -B #002b36 -F #657b83
