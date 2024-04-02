#!/usr/bin/sh

frequency=$(awk '/MHz/{ temp+=$4; n++ } END { printf("%0.0f\n", temp/n) }' "/proc/cpuinfo")
song=$(mocp --format "%song")
dimensions=$(xdpyinfo | awk '/dimensions/{print $2}')
time=$(date +"%A %B %d | %r")

if [[ "$dimensions" == "1080x1920" ]]; then
	echo "$time |"
elif [[ $song ]]; then
	echo "$song |"
fi
