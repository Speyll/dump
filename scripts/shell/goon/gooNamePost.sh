#!/bin/bash

# Set directories
DIR1="/media/BX200/pron/hentai/"
DIR2="/media/BX200/pron/dump/0toEncode/encVids/"

# Define a pattern-to-author map
declare -A author_map=(
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
    ["天平キツネ"]="extrafoxes"
    ["ななし"]="tsubasamx"
    ["痕久"]="zabhs123"
    ["こしあん"]="aliceallice96"
    ["あわわ＞＜"]="awawa1887"
    ["托尼带水"]="tonyds"
    ["MMD風俗ALBATROSS"]="mmdalbatross"
    ["Arima Kaori"]="lzx999111"
    ["ぷりんちゅ"]="purinchu"
)

# Function to extract author from filename
extract_author() {
    local filename="$1"
    local author=""

    # Check against author_map
    for key in "${!author_map[@]}"; do
        if [[ "$filename" == *"$key"* ]]; then
            author="${author_map[$key]}"
            break
        fi
    done

    # Default fallback if no match in map
    if [[ -z "$author" ]]; then
        # Attempt to extract text before the first underscore or square bracket
        author=$(echo "$filename" | sed -E 's/^([^_]+).*/\1/' | tr '[:upper:]' '[:lower:]')
    fi

    echo "$author"
}

# Function to determine the next available entry number
get_next_entry_number() {
    local author="$1"

    # Find all files in DIR1 matching the author pattern
    matching_files=($(find "$DIR1" -type f -iname "${author}_[0-9]*.mp4"))
    if [ "${#matching_files[@]}" -gt 0 ]; then
        # Extract numbers from filenames and determine the max
        max_entry=$(printf "%s\n" "${matching_files[@]}" | sed -E "s/^.*${author}_([0-9]+)\.mp4$/\1/" | sort -n | tail -1)
        echo $((10#$max_entry + 1))
    else
        echo 1
    fi
}

# Loop through files in DIR2
for file in "$DIR2"/*.mp4; do
    # Skip if no .mp4 files are present
    [[ -e "$file" ]] || continue

    # Extract base filename
    filename=$(basename "$file")

    # Extract author
    author=$(extract_author "$filename")

    # If author could not be determined, skip the file
    if [[ -z "$author" ]]; then
        echo "Could not determine author for $filename. Skipping."
        continue
    fi

    # Get the next entry number for this author
    next_entry=$(get_next_entry_number "$author")
    next_entry=$(printf "%03d" "$next_entry") # Zero-pad to 3 digits

    # Construct the new filename
    new_filename="${author}_${next_entry}.mp4"
    new_filepath="$DIR2/$new_filename"

    # Rename the file
    if mv "$file" "$new_filepath"; then
        echo "Renamed $filename to $new_filename"
    else
        echo "Failed to rename $filename"
    fi
done
