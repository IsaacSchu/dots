#!/bin/bash

WALLPAPER_DIR="$HOME/bin/wallpapers/wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f -not -path "$WALLPAPER_DIR/.git/*" | shuf -n 1)

feh --bg-fill "$WALLPAPER"


