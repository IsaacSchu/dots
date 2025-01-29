#!/bin/bash
export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

/usr/bin/killall hyprpaper
/usr/bin/killall mpvpaper

WALLPAPER_DIR="$HOME/wallpapers"
CONFIG="$HOME/wallpapers/hyprpaper.conf"
>"$CONFIG"
MONITORS=$(/usr/bin/hyprctl monitors | grep "Monitor" | awk '{print $2}')

for MONITOR in $MONITORS; do
    FILE=$(find "$WALLPAPER_DIR" -type f \
        -not -path "$WALLPAPER_DIR/.git/*" \
        -not -name "*.sh" \
        -not -name "*.conf" | shuf -n 1)

    if [[ "$FILE" == *.mp4 ]]; then
        # Use mpvpaper for video wallpapers
        /usr/bin/mpvpaper -p -o "--profile=gpu-hq --hwdec=auto --no-audio --loop-file gpu-api=vulkan --no-osd-bar panscan=1 --no-border --config=no" $MONITOR $FILE &
    else
        # Add image wallpaper to hyprpaper config
        echo -e "preload = $FILE\nwallpaper = $MONITOR, $FILE" >>"$CONFIG"
    fi
done

# Start hyprpaper if any non-video wallpapers were set
if grep -q "wallpaper" "$CONFIG"; then
    /usr/bin/hyprpaper --config "$CONFIG" &
fi
