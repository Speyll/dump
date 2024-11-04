#!/bin/bash

# Set directories
DIR1="/media/BX200/pron/hentai/" 
DIR2="/media/BX200/pron/dump/0toEncode/" 

# Define a pattern-to-author map, using quotes around each key and value
declare -A author_map
author_map=(
    ["法国原神糕手"]="blacknova"
    ["Wayne HMV"]="waynehmv"
    ["煌めく星"]="kiramekuhoshi"
    ["sleeping"]="threetomatoes"
    ["李十七夜"]="lishiliuye"
    ["我要成为射蛇糕手"]="scydw1"
    ["白墨"]="6aminoac9"
    ["s烁乐"]="1595413150qqcom"
    ["昼9724"]="noon9724"
    ["ENE贵音"]="ene"
    ["reui_s"]="qwe6s"
    ["Hoshino Homura"]="hoshinohomura"
    ["Ahoy pony"]="ahoypony"
    ["March Shadow"]="marchshadow"
    ["包子"]="ewewaa"
    ["iw西琳"]="sirin5201"
    ["mmmohhsh"]="wouldiiii"
    ["uploading"]="bbcklii585"
    ["JYB_UNKNOWN"]="jybunkown"
    ["Magic conch"]="magicconch"
    ["幽墨"]="9aminoac6"
)

# Loop through files in the second directory
for file in "$DIR2"/*.mp4; do
    # Extract base filename
    filename=$(basename "$file")

    # Attempt to match the author using author_map, or fallback to filename extraction
    author=""
    for key in "${!author_map[@]}"; do
        if [[ "$filename" == *"$key"* ]]; then
            author="${author_map[$key]}"
            break
        fi
    done

    # If no mapped author was found, default to extracting the author name from the filename
    if [[ -z "$author" ]]; then
        author=$(echo "$filename" | sed -E 's/^[0-9-]+_([^ ]+).*/\1/' | tr '[:upper:]' '[:lower:]')
    fi

    # Find files in DIR1 that match this author
    matching_files=($(ls "$DIR1" | grep -i "^${author}_[0-9]*\.mp4$"))
    if [ "${#matching_files[@]}" -gt 0 ]; then
        # Find the highest entry number for the author in the first directory
        max_entry=$(printf "%s\n" "${matching_files[@]}" | sed -E "s/^${author}_([0-9]+)\.mp4$/\1/i" | sort -n | tail -1)
        next_entry=$(printf "%03d" $((10#$max_entry + 1)))

        # Rename the file in the second directory
        new_filename="${author}_${next_entry}.mp4"
        mv "$file" "$DIR2/$new_filename"
        echo "Renamed $filename to $new_filename"
    else
        echo "No matching files found for author $author in $DIR1. Skipping $filename"
    fi
done

