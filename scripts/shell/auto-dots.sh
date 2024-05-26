#!/bin/sh
# Void Linux Post-Installation Script for Wayland
# Author: Speyll
# Last-update: 13-05-2024

# Enable debugging output and exit on error
set -x

# Clone and set up dotfiles
git clone https://github.com/speyll/dotfiles "$HOME/dotfiles"
cp -r "$HOME/dotfiles/."* "$HOME/"
rm -rf "$HOME/dotfiles"
chmod -R +X "$HOME/.local/bin" "$HOME/.local/share/applications" "$HOME/.config/autostart/"
chmod +x "$HOME/.config/yambar/sway-switch-keyboard.sh" "$HOME/.config/yambar/xkb-layout.sh" "$HOME/.config/waybar/sway-switch-keyboard.sh" "$HOME/.config/waybar/xkb-layout.sh" "$HOME/.config/autostart/*" "$HOME/.local/bin/*" 
ln -s "$HOME/.config/mimeapps.list" "$HOME/.local/share/applications/"
rm -rf README.md
rm -rf .git
