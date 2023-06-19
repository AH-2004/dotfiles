#!/usr/bin/sh

backlight="/sys/class/backlight/intel_backlight"
actual_brightness=$(cat "$backlight/actual_brightness")
max_brightness=$(cat "$backlight/max_brightness")
calc=$(printf "%.0f" $(echo $actual_brightness/$max_brightness*100 | bc -l))

echo "  $calc%  "
