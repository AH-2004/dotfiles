#!/usr/bin/sh

defaultSink=$(pactl get-default-sink)
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}' | tr -d '%')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
device=$(pactl list sinks | sed -n "/$defaultSink/,/^$/p" | awk '/Active Port:/{print $3}')
icon=""
iconMuted=""

if [[ "$device" == "analog-output-headphones" ]]; then
	icon=""
	iconMuted=""
fi
	
if [[ "$mute" == "yes" ]]; then
	echo " $iconMuted $volume |"
elif [[ "$volume" -ge "50" ]]; then
	echo " $icon $volume |"
elif [[ "$volume" -gt "0" ]]; then
	echo " $icon $volume |" 
elif [[ "$volume" -eq "0" ]]; then
	 echo " $icon $volume |" 
fi
