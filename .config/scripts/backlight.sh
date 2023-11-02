#!/usr/bin/sh

backlight=""

for light in "/sys/class/backlight"/*; do
	if [[ -d "$light" && "$light" == *"backlight"* ]]; then
		actual_brightness=$(($(cat "$light/actual_brightness") * 100))
		max_brightness=$(cat "$light/max_brightness")
		backlight=$(printf "%.0f" $(($actual_brightness / $max_brightness)))
	fi
done

if [[ "$backlight" != "" ]]; then
	echo "  $backlight |"
fi
