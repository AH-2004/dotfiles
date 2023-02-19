#!/usr/bin/sh
# SSID=$(nmcli -t -f name connection show --active | head -n 1)

# if [[ $SSID ==  "" ]]; then
#     echo "<txt></txt>"
#  else
#     echo "<txt>$SSID</txt>"
# fi

# echo $SSID

while true
do
	echo $(nmcli -t -f name connection show --active | head -n 1)
done
