#!/usr/bin/sh

backlight=""

for f in "/sys/class/backlight"/*; do
	if [[ -d "$f" && "$f" == *"backlight"* ]]; then
		actual_brightness=$(cat "$f/actual_brightness")
		max_brightness=$(cat "$f/max_brightness")
		backlight=$(($actual_brightness * 100 / $max_brightness))
	fi
done

if [[ "$backlight" != "" ]]; then
	echo "  $backlight |"
fi

