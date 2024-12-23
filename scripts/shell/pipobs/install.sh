#!/bin/sh

# Determine the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define the virtual environment directory
VENV_DIR="$HOME/videos/rec/pipobs"

# Create the virtual environment
python -m venv "$VENV_DIR"

# Activate the virtual environment
# Using 'source' to ensure activation occurs in the current shell
. "$VENV_DIR/bin/activate"

# Upgrade pip to the latest version
pip install --upgrade pip

# Install the obsws-python package
pip install obsws-python

# Copy replay.py from the script's directory to the virtual environment directory
cp "$SCRIPT_DIR/replay.py" "$VENV_DIR/"

# Deactivate the virtual environment (optional)
deactivate
