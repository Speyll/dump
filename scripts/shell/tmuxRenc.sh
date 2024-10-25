#!/bin/sh

# Define the tmux session name
SESSION_NAME="rec"

# Check if the session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists. Choose a different name or terminate the existing session."
    exit 1
fi

# Start tmux session with all windows configured
tmux new-session -d -s "$SESSION_NAME" -n "video-reenc" -c "/media/BX200/pron/dump/0toEncode/" \; \
    new-window -n "audio-reenc" -c "/media/BX200/pron/dump/0toEncode/audio" \; \
    new-window -n "ufetch" -c "$HOME" \; \
    send-keys -t "$SESSION_NAME:ufetch" "ufetch-void" C-m

# Attach to the session
tmux attach -t "$SESSION_NAME"
