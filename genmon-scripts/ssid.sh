#!/usr/bin/sh
SSID=$(nmcli -t -f name connection show --active)

if [[ $SSID ==  "" ]]; then
    echo "<txt></txt>"
 else
    echo "<txt>$SSID</txt>"
fi
