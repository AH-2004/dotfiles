#!/usr/bin/sh

icons=("" "" "" "" "" "" "" "" "")
icon=4
capacity=""
status=""

for f in "/sys/class/power_supply"/*; do
	if [[ -d "$f" && "$f" == *"BAT"* ]]; then
		capacity=$(cat "$f/capacity")
		status=$(cat "$f/status")
	fi
done

if [[ "$capacity" == "" ]]; then
	exit
fi

if [[ "$status" != "Discharging" ]]; then
	icon=8
else
	[[ $capacity -le 14 ]] && icon=0
	[[ $capacity -ge 28 ]] && icon=1
	[[ $capacity -ge 42 ]] && icon=2
	[[ $capacity -ge 56 ]] && icon=3
	[[ $capacity -ge 70 ]] && icon=4
	[[ $capacity -ge 84 ]] && icon=5
	[[ $capacity -ge 98 ]] && icon=6
	[[ $capacity -eq 100 ]] && icon=7
fi

echo " ${icons[$icon]}" "$capacity |"
