#!/bin/bash

killall hyprpaper

WALLPAPER_DIR="$HOME/wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f -not -path "$WALLPAPER_DIR/.git/*" | shuf -n 1)

echo -e "preload = $WALLPAPER\nwallpaper =, $WALLPAPER" | tee /home/lain/.config/wallpapers/hyprpaper.conf

hyprpaper --config /home/lain/.config/wallpapers/hyprpaper.conf &
