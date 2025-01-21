#!/bin/bash

# Set directories
DIR1="/media/BX200/pron/real/"
DIR2="/media/BX200/pron/dump/0toEncode/encVids/"

# Loop through files in the second directory
for file in "$DIR2"/*.mp4; do
    # Extract base filename and identifier
    filename=$(basename "$file")
    identifier=$(echo "$filename" | awk '{print $2}' | sed -E 's/^[0-9]+//')

    # Ensure identifier is valid and remove any trailing ".mp4"
    identifier="${identifier%.mp4}"

    if [[ -n "$identifier" ]]; then
        # Find files in DIR1 that match the identifier
        matching_files=($(ls "$DIR1" | grep -i "^${identifier}_[0-9]*\.mp4$"))
        if [ "${#matching_files[@]}" -gt 0 ]; then
            # Find the highest sequence number for the identifier in DIR1
            max_entry=$(printf "%s\n" "${matching_files[@]}" | sed -E "s/^${identifier}_([0-9]+)\.mp4$/\1/i" | sort -n | tail -1)
            next_entry=$(printf "%03d" $((10#$max_entry + 1)))
        else
            # Start from 001 if no matching files exist
            next_entry="001"
        fi

        # Rename the file in DIR2
        new_filename="${identifier}_${next_entry}.mp4"
        mv "$file" "$DIR2/$new_filename"
        echo "Renamed $filename to $new_filename"
    else
        echo "Could not extract identifier from $filename. Skipping."
    fi
done
