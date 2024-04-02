#!/usr/bin/bash

backlight=""

for f in "/sys/class/backlight"/*; do
	if [[ -d "$f" && "$f" == *"backlight"* ]]; then
		actual_brightness=$(cat "$f/actual_brightness")
		max_brightness=$(cat "$f/max_brightness")
		backlight=$(($actual_brightness * 100 / $max_brightness))
	fi
done

dunstify -a "Brightness" "progress_bar" -h int:value:$backlight -r 2 -t 1000
