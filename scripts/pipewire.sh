#/bin/bash

killall pipewire
killall pipewire-pulse
killall wireplumber

pipewire &
pipewire-pulse &
wireplumber &
