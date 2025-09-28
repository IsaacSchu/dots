#!/bin/bash

sudo xrandr --output DP-2 --mode 2560x1440 --rate 240

sudo xrandr --output HDMI-0 --mode 3840x2160 --rate 60

sudo xinput --set-prop 15 "libinput Accel Speed" -1

sudo xrandr --output DP-0 --right-of DP-4

~/bin/scripts/fehwallpape.sh &

picom -b &


