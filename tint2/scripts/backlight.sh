#!/usr/bin/sh

backlight="/sys/class/backlight/intel_backlight"
actual_brightness=$(cat "$backlight/actual_brightness")
max_brightness=$(cat "$backlight/max_brightness")

echo "$actual_brightness"
echo "$max_brightness"
