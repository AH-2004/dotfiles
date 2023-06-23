#!/usr/bin/sh

mapfile -t ssids_map <<< "$(nmcli -t -f NAME connection show --active)"

ssids=""

for ssid in "${ssids_map[@]}"; do
    if [[ "$ssid" == "lo" ]]; then
		continue
	fi

	if [[ "$ssid" == "Ethernet" ]]; then
		ssids+=" $ssid, "
	else
		ssids+=" $ssid, "
	fi
done

ssids="${ssids%, }"

if [[ "$ssids" != "" ]]; then
	echo " $ssids |"
fi

