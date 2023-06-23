#!/usr/bin/sh

thermal=""

for f in "/sys/class/thermal"/*; do
	if [[ -d "$f" && "$f" == *"thermal_zone"* ]]; then
		temp=$(cat "$f/temp")
		round_temp=$(printf "%.0f" "$(echo "scale=2; $temp/1000" | bc)")
		thermal+=" $round_temp°C" 
	fi
done

if [[ "$thermal" != "" ]]; then
	echo "$thermal |"
fi
