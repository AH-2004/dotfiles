#!/usr/bin/sh

frequency=$(awk '/MHz/{ temp+=$4; n++ } END { printf("%0.0f\n", temp/n) }' "/proc/cpuinfo")

echo "$frequency MHz |"
