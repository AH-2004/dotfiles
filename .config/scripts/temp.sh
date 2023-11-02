#!/usr/bin/sh

sensors=('."thinkpad-isa-0000"."CPU"."temp1_input"')
thermal=""

for sensor in "${sensors[@]}"; do
	thermal+=$(printf " %.0f°C" $(sensors -j 2> /dev/null | jq "$sensor"))
done

if [[ "$thermal" != "" ]]; then
	echo "$thermal |"
fi
