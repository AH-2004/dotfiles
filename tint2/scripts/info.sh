#!/usr/bin/sh
TEMPS=$(~/.config/tint2/scripts/temps.sh)
MEDIA=$(playerctl -p spotify metadata --format '{{artist}} - {{title}}')
TITLE=$(~/.config/tint2/scripts/window.sh --name)
SSID=$(~/.config/tint2/scripts/ssid.sh)
echo "$MEDIA"
echo "$TEMPS    $SSID    $TITLE"
