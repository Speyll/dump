#!/bin/bash

# Create the output folder if it doesn't exist
output_folder="./trimmed"
mkdir -p "$output_folder"

# Loop through each video file with specified extensions in the current folder
for video in *.mp4 *.mkv *.ts *.mov *.avi; do
    # Check if the file exists to avoid processing non-matching patterns
    [ -e "$video" ] || continue
    
    # Get the base name of the video file
    base_name=$(basename "$video")
    
    # Define the output file path
    output_file="$output_folder/$base_name"
    
    # Calculate the start time to trim the first 5 seconds
    start_time="00:00:03"
    
    # Cut the first 5 seconds and copy streams without re-encoding
    ffmpeg -ss "$start_time" -i "$video" -c copy "$output_file"
done

echo "Finished processing all videos."

