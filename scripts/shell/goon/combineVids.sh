#!/bin/bash

# Create a list of all video files in the directory
videos="filelist.txt"
> "$videos"
for f in *.mp4; do
  echo "file '$PWD/$f'" >> "$videos"
done

# Combine videos without re-encoding
ffmpeg -f concat -safe 0 -i "$videos" -c copy output.mp4

# Cleanup
rm "$videos"

