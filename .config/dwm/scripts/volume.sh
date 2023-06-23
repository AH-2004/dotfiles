#!/usr/bin/sh

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}' | tr -d '%')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')


if [[ "$mute" == "yes" ]]; then
	echo "  $volume |"
elif [[ "$volume" -ge "50" ]]; then
	echo "  $volume |"
elif [[ "$volume" -gt "0" ]]; then
	echo "  $volume |" 
elif [[ "$volume" -eq "0" ]]; then
	 echo "  $volume |" 
fi
