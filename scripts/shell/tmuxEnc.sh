#!/bin/sh

# Configuration
SESSION_NAME="rec"
BASE_DIR="/media/BX200/pron/dump/0toEncode"

# Check for existing session using native tmux flags
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    sleep 1
    exec tmux attach -t "$SESSION_NAME"
    exit  # Fallback in case attach fails
fi

# Create session with all windows in single command list
tmux new-session -d -s "$SESSION_NAME" -n "video-reenc" -c "$BASE_DIR/" <<TMUX_CONFIG
new-window -n "audio-reenc" -c "$BASE_DIR/audio"
new-window -n "scripts" -c "$BASE_DIR/scripts"
new-window -n "pictures" -c "$BASE_DIR/0pictures"
new-window -n "spefetch" -c "$HOME"
send-keys -t "spefetch" "spefetch" Enter
TMUX_CONFIG

# Smart attach (only if not already in tmux)
[ -z "$TMUX" ] && exec tmux attach -t "$SESSION_NAME"
