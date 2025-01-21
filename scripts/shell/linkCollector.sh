#!/bin/bash

# File to store the collected links
LINKS_FILE=~/downloads/jd_links.txt

# Function to check if a URL is already in the file
url_exists() {
    grep -Fxq "$1" "$LINKS_FILE"
}

# Monitor the clipboard for new links
while true; do
    # Get the current clipboard content
    CLIPBOARD_CONTENT=$(wl-paste --no-newline)

    # Check if the clipboard content is a valid URL and not already in the file
    if [[ $CLIPBOARD_CONTENT =~ ^https?:// ]] && ! url_exists "$CLIPBOARD_CONTENT"; then
        echo "New URL detected: $CLIPBOARD_CONTENT"
        echo "$CLIPBOARD_CONTENT" >> "$LINKS_FILE"
        # Send a desktop notification
        notify-send -t 2000 "New URL Added" "$CLIPBOARD_CONTENT"
    fi

    # Wait for a short period before checking again
    sleep 2
done

