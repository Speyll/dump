#!/bin/sh

i="%{F#073642}"
e="%{F-}"

# Get your public IP
pubip (){
	while :; do
		var=$(curl -s ipinfo.io/ip)
		echo "$iO$e $var"
    done
}

# Get your private IP
privip (){
	while :; do
		var=$(ip addr show | grep wl | awk '/inet/ {print $2}')
		echo "$iO$e $var"
    done
}

# Memory management
memory (){
	while :; do
		var=$(free -h | awk '/Mem/ {print $2}')
		echo "$iO$e $var"
    done
}

# Hard drive free space.
drive (){
	while :; do
		var=$(df -h | grep '/$' | awk '{print $5}')
		echo "$iO$e $var"
    done
}

# CPU temp.
cpu_temp (){
	while :; do
		var=$(sensors | awk '/Core 0/ {print $3}')
		echo "$iO$e $var"
    done
}

# Mixer volume level
volume (){
	while :; do
		var=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))
		echo "$iO$e $var"
    done
}

# Show the time and date
print_date (){
	while :; do
		var=$(date -u)
		echo "$iO$e $var"
		sleep 4s
    done
}

# Show the local temperature. Change 'Algiers' to your local area.
weather(){
	while :; do
		var=$(curl -s wittr.in/Algiers?format=1)
		echo "$iO$e $var"
    done
}

while true
do
	BAR_INPUT="%{l}%{c}%{r}$(privip) $(pubip) $(cpu_temp) $(memory) $(drive) $(volume)% $(print_date)"
	echo $BAR_INPUT
	sleep 1s
done

#lemonbar -g x20 -o -1 -f "Cozette:size=9" -B "#002b36" -F "#657b83"
