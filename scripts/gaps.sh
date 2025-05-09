#!/bin/bash

HYPRGAPS=$(hyprctl getoption general:gaps_in | awk 'NR==1{print $3}')
if [ "$HYPRGAPS" = 1 ]; then
    hyprctl --batch "\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;"
    echo "test"
    exit
else
    hyprctl --batch "\
        keyword general:gaps_in 1;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;"

fi
