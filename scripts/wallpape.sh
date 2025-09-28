#!/bin/zsh

WALLPAPER_DIR="$HOME/wallpapers"
CONFIG_FILE="/home/lain/wallpapers/hyprpaper.conf"
>"$CONFIG_FILE" # Clear the config file

# Stop any running instances of hyprpaper and mpvpaper
pkill hyprpaper mpvpaper 2>/dev/null

MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

for MONITOR in $MONITORS; do
    FILE=$(find "$WALLPAPER_DIR" -type f -not -path "$WALLPAPER_DIR/.git/*" \
        -not -name "*.sh" -not -name "*.conf" | shuf -n 1)

    if [[ "$FILE" =~ \.mp4$ ]]; then
        echo "Setting video wallpaper for $MONITOR with mpvpaper: $FILE"
        mpvpaper "$MONITOR" "$FILE" &
    else
        echo -e "preload = $FILE\nwallpaper = $MONITOR, $FILE" >>"$CONFIG_FILE"
    fi
done

if grep -q "wallpaper" "$CONFIG_FILE"; then
    echo "Starting hyprpaper with config: $CONFIG_FILE"
    hyprpaper --config "$CONFIG_FILE" &
fi
