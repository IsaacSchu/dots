#!/bin/bash

# Kill existing hyprpaper instances
killall hyprpaper

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/wallpapers"

# Create configuration directory if it doesn't exist
CONFIG_DIR="$HOME/.config/wallpapers"
mkdir -p "$CONFIG_DIR"

# Path to the Hyprpaper configuration file
CONFIG_FILE="$CONFIG_DIR/hyprpaper.conf"

# Start with a fresh config file
> "$CONFIG_FILE"

# Get all connected monitors
MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Assign a random wallpaper to each monitor
for MONITOR in $MONITORS; do
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f -not -path "$WALLPAPER_DIR/.git/*" | shuf -n 1)
    echo "monitor = $MONITOR, $WALLPAPER" >> "$CONFIG_FILE"
done

# Start Hyprpaper with the new configuration
hyprpaper --config "$CONFIG_FILE" &

