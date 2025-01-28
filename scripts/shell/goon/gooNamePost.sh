#!/bin/bash

# Set directories
DIR1="/media/BX200/pron/hentai/"
DIR2="/media/BX200/pron/dump/0toEncode/encVids/"

# Define a pattern-to-author map (case-insensitive matching)
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

# Associative array to track processed authors and their next entry numbers
declare -A processed_authors

# Function to extract author from filename
extract_author() {
    local filename="$1"
    local author=""
    local filename_lower=$(echo "$filename" | tr '[:upper:]' '[:lower:]')  # Case-insensitive match

    # Check against author_map (case-insensitive)
    for key in "${!author_map[@]}"; do
        local key_lower=$(echo "$key" | tr '[:upper:]' '[:lower:]')
        if [[ "$filename_lower" == *"$key_lower"* ]]; then
            author="${author_map[$key]}"
            break
        fi
    done

    # Fallback: Extract from filename if no match found
    if [[ -z "$author" ]]; then
        author=$(echo "$filename" | sed -E 's/^[^_]*_([^ _【]+).*/\1/' | tr '[:upper:]' '[:lower:]')
        # Remove any non-alphanumeric characters except underscores
        author=$(echo "$author" | sed 's/[^a-z0-9_]//g')
    fi

    echo "$author"
}

# Loop through files in DIR2
for file in "$DIR2"/*.mp4; do
    # Skip if no .mp4 files are present
    [[ -e "$file" ]] || continue

    filename=$(basename "$file")
    author=$(extract_author "$filename")

    # Skip if author is empty or problematic
    if [[ -z "$author" || "$author" =~ ^[0-9]+$ ]]; then
        echo "Skipping $filename: Could not determine valid author."
        continue
    fi

    # Determine next entry number
    existing_max=0
    # Check existing files in DIR1
    while IFS= read -r -d $'\0' f; do
        entry_num=$(basename "$f" | sed -E "s/^${author}_([0-9]+)\.mp4$/\1/i")
        if [[ $entry_num =~ ^[0-9]+$ ]] && (( entry_num > existing_max )); then
            existing_max=$entry_num
        fi
    done < <(find "$DIR1" -type f -iname "${author}_[0-9][0-9][0-9].mp4" -print0)

    # Check if author has been processed in this run
    if [[ -n "${processed_authors[$author]}" ]]; then
        current_max=$(( existing_max > processed_authors[$author] ? existing_max : processed_authors[$author] ))
    else
        current_max=$existing_max
    fi

    next_entry=$((current_max + 1))
    processed_authors["$author"]=$next_entry

    # Pad entry number to 3 digits
    next_entry_padded=$(printf "%03d" "$next_entry")
    new_filename="${author}_${next_entry_padded}.mp4"
    new_filepath="${DIR2}/${new_filename}"

    # Rename the file
    if [[ ! -e "$new_filepath" ]]; then
        mv -- "$file" "$new_filepath"
        echo "Renamed: $filename -> $new_filename"
    else
        echo "ERROR: $new_filename already exists. Skipping $filename."
    fi
done
