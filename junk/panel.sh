#!/bin/sh

# a="%{F#88C0D0}"
# t="%{F-}"

# You can use either mpc or mpd here to display now playing info
playing (){
}

# Get your public IP
pubip (){
	curl api.ipify.org
}

# Get your private IP
privip (){
	ip addr show | grep wl | awk '/inet/ {print $2}'
}

# Covid19 tracking api set to Australia, change to your country
covid19 () {
	curl https://corona-stats.online/Algeria\?format\=json | python3 -c 'import sys,json;data=json.load(sys.stdin)["data"][0];print("?",data["cases"],"?",data["deaths"])'
}

# Memory management
memory (){
	free -h | awk '/Mem {print $2 "\t" print $3}'
}

# Hard drive free space.
drive (){
	df -h | grep '/$' | awk '{print $5}'
}

# CPU temp. Again, this is FreeBSD specific. Change variables for Linux.
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
    LOCATION=Algiers

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "%s" "$(curl -s wttr.in/$LOCATION?format=1)"
    else
        printf "%s" "$(curl -s wttr.in/$LOCATION?format=1 | grep -o "[0-9].*")"
    fi
    printf "%s\n" "$SEP2"
 }

while true
do
	echo -e "%{l}?$(cpu_temp) ?$(memory) ?$(drive) %{c}$(playing) $(covid19) %{r}$(privip) $(pubip) ?$(weather) ?$(volume)% ?$(print_date)" \
	| lemonbar \
	-g x20 \
	-o -1 -f "Cozette:size=9" \
    -B \#2E3440 \
    -F \#D8DEE9
	sleep 1s
done
