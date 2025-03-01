#!/bin/sh

# Configuration
SESSION_NAME="rec"
BASE_DIR="/media/BX200/pron"

# Check for existing session
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    sleep 1
    exec tmux attach -t "$SESSION_NAME"
    exit
fi

# Create new session and windows
tmux new-session -d -s "$SESSION_NAME" -n "video-reenc" -c "$BASE_DIR/dump/0toEncode"
tmux new-window -t "$SESSION_NAME" -n "audio-reenc" -c "$BASE_DIR/dump/0toEncode/audio"
tmux new-window -t "$SESSION_NAME" -n "pic-reenc" -c "$BASE_DIR/dump/0toEncode/0pictures"
tmux new-window -t "$SESSION_NAME" -n "scripts" -c "$BASE_DIR/scripts"
tmux new-window -t "$SESSION_NAME" -n "pictures" -c "$BASE_DIR/pics/slides"
tmux new-window -t "$SESSION_NAME" -n "spefetch" -c "$HOME"
tmux send-keys -t "$SESSION_NAME:spefetch" "spefetch" Enter

# Attach to session (if not already in tmux)
[ -z "$TMUX" ] && exec tmux attach -t "$SESSION_NAME"
