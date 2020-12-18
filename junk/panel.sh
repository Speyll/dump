#!/bin/sh

# Colors
i="%{F#88C0D0}[%{F-}"
e="%{F#88C0D0}]%{F-}"

# Get your public IP
pubip (){
	curl -s ipinfo.io/ip
}

# Covid19 tracking api set to Australia, change to your country
covid19 (){
	curl -s https://corona-stats.online/Algeria\?format\=json | python3 -c 'import sys,json;data=json.load(sys.stdin)["data"][0];print("?",data["cases"],"?",data["deaths"])'
}

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

# Show the local temperature. Change 'Algiers' to your local area.
weather(){
	curl -s wittr.in/Algiers?format=1
}

while true
do
	BAR_INPUT="%{l}%{c}%{r}$i$(privip)$e $i$(pubip)$e $i$(cpu_temp)$e $i$(memory)$e $i$(drive)$e $i$(volume)%$e $i$(print_date)$e"
	echo $BAR_INPUT
	sleep 1
done

#lemonbar -g x20 -o -1 -f "Cozette:size=9" -B "#002b36" -F "#657b83"
