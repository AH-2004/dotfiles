#!/usr/bin/sh
SSID=$(nmcli -t -f name connection show --active | head -n 1)
echo $SSID
