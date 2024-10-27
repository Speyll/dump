#!/bin/bash

# Loop through all .mp4 files in the current directory
for file in *.mp4; do
  echo "Processing file: $file"
  
  # Check if the file matches the expected format YYYYMMDD_配信###.mp4
  if [[ $file =~ ^[0-9]{8}_.+\.mp4$ ]]; then
    echo "File matches the expected format."

    # Extract the date part (first 8 characters)
    date_part=${file:0:8}
    
    # Format the date part to yyyy-mm-dd
    formatted_date=$(echo "$date_part" | sed 's/\(....\)\(..\)\(..\)/\1-\2-\3/')

    # Get the file extension
    extension="${file##*.}"

    # Construct the new filename
    new_filename="${formatted_date}.${extension}"

    # Rename the file
    echo "Renaming $file to $new_filename"
    mv "$file" "$new_filename"
  else
    echo "Skipping file with unexpected format: $file"
  fi
done

echo "Renaming completed."

