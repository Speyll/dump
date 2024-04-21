#!/bin/sh

# Get clipboard content
clipboard_text=$(xclip -selection clipboard -o)

if [ -z "$clipboard_text" ]; then
    echo "No text found in the clipboard."
    exit 1
fi

# Save the clipboard content to a text file (append mode)
echo "$clipboard_text" >> trash.md

# Initialize git if not already done
if [ ! -d ".git" ]; then
    git init
fi

# Add the changes
git add -A

# Commit and push
git commit -m "Added clipboard text"
git push
