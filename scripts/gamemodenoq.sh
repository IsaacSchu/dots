#!/bin/bash

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0;\
        dispatch exec killall mpvpaper;\
        dispatch exec killall hyprpaper;\
        keyword unbind , mouse:275;\
        keyword unbind , mouse:276;"
    exit
else
    if ! pgrep -x mpvpaper >/dev/null && ! pgrep -x hyprpaper >/dev/null; then
        bash /home/lain/bin/wallpapers/wallpaper.sh
    fi
    #   if ! ip link show mullvad >/dev/null; then
fi
hyprctl reload
