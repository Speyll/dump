#!/bin/sh

# Colors settings.
c="%{F#6c71c4}"
e="%{F-}"

# Show the time and date.
print_date (){
	var=$(date -u)
	echo "$c[$e $var$c]$e "
}

# Mixer volume level.
volume (){
	var=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))
	echo "$c[$e $var $c]$e"
}

# CPU temp.
cpu_temp (){
	var=$(sensors | awk '/Core 0/ {print $3}')
	echo "$c[$e $var$c]$e"
}

# Memory management
memory (){
    var=$(free -h | awk '/Mem/ {print $2}')
    echo "$c[$e $var$c]$e"
}

# Hard drive free space.
drive (){
	var=$(df -h | grep '/$' | awk '{print $5}')
	echo "$c[$e $var $c]$e"
}

# Get your private IP.
privip (){
    var=$(ip addr show | grep wl | awk '/inet/ {print $2}')
	echo "$c[$e $var$c]$e"
}

# Get your public IP.
pubip (){
	var=$(curl -s ipinfo.io/ip)
	echo "$c[⮂$e $var$c]$e"
}

while true
do
    BAR_INPUT="%{l}%{c}%{r}$(pubip) $(privip) $(drive) $(memory) $(cpu_temp) $(volume)% $(print_date)"
	echo $BAR_INPUT
	sleep 1
done
