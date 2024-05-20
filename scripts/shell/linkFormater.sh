#!/bin/bash

# Function to extract name from URL
get_name() {
    local url=$1
    local name=""
    name=$(echo "$url" | grep -oE '[^/]+$' | cut -d'.' -f1)
    if [ -z "$name" ]; then
        name=$(echo "$url" | grep -oE '[^/]+/$' | sed 's#/##')
    fi
    echo "$name"
}

# Function to format link into JSON
format_link() {
    local url=$1
    local tags=$2
    local name=$(get_name "$url")
    if [[ -z "$name" ]]; then
        name="Unnamed"
    fi
    echo "{\"name\": \"$name\", \"url\": \"$url\", \"tags\": [\"$tags\"]}"
}

# Main script
input_file="links.txt"
output_file="formatted_links.json"

echo "[" > "$output_file"

while IFS= read -r line; do
    if [[ $line == https* ]]; then
        if [[ $line == *patreon* ]]; then
            tags="hentai, ntr"
        else
            tags="hentai, ntr" # Assuming all non-patreon links have the same tags
        fi
        echo "$(format_link "$line" "$tags"),"
    fi
done < "$input_file" >> "$output_file"

# Remove trailing comma and add closing bracket
sed -i '$ s/,$//' "$output_file"
echo "]" >> "$output_file"

echo "Formatted links saved to $output_file"

