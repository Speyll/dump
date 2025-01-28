#!/bin/bash

# Configuration
LINKS_FILE=~/downloads/jd_links.txt
CHECK_INTERVAL=0.3  # Reduced sleep time for better responsiveness

# Create the file if it doesn't exist
touch "$LINKS_FILE"

# Declare associative array for O(1) lookups
declare -A SEEN_URLS

# Load existing URLs into memory
while IFS= read -r url; do
    SEEN_URLS["$url"]=1
done < "$LINKS_FILE"

last_content=""
while true; do
    current_content=$(wl-paste --no-newline 2>/dev/null)
    
    # Only process if content changed and is not empty
    if [[ "$current_content" != "$last_content" && -n "$current_content" ]]; then
        # Simple URL validation regex (adjust as needed)
        if [[ $current_content =~ ^https?://[^[:space:]]+ ]]; then
            trimmed_url=$(awk '{$1=$1};1' <<< "$current_content")  # Trim whitespace
            
            # Check if URL is new
            if [[ -z "${SEEN_URLS[$trimmed_url]}" ]]; then
                echo "$trimmed_url" >> "$LINKS_FILE"
                SEEN_URLS["$trimmed_url"]=1
                notify-send -t 2000 "JD Link Added" "$trimmed_url"
                echo "[$(date +%T)] New URL stored: $trimmed_url"
            fi
        fi
        last_content="$current_content"
    fi
    
    sleep $CHECK_INTERVAL
done
