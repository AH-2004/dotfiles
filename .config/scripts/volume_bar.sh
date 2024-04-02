#!/usr/bin/bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}' | tr -d '%')

dunstify -a "Volume" "progress_bar" -h int:value:$volume -r 1 -t 1000
