#!/usr/bin/sh
TCTL=$(printf "%.0f" $(sensors -j k10temp-pci-00c3 | jq '."k10temp-pci-00c3"."Tctl"."temp1_input"'))
TITLE=$(playerctl -p spotify metadata --format '{{artist}} - {{title}}')
WIN_TITLE=$(./title.sh)
SSID=$(./ssid.sh)
echo "$TITLE"
echo "$TCTL °C    $SSID    $WIN_TITLE"
