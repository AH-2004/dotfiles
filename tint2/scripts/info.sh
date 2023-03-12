#!/usr/bin/sh
TEMPS=$(~/.config/tint2/scripts/temps.sh)
MEDIA=$(playerctl -i chromium metadata --format '{{title}}')
TITLE=$(~/.config/tint2/scripts/window.sh --name)
SSID=$(~/.config/tint2/scripts/ssid.sh)
echo "$MEDIA"
echo "$TEMPS    $SSID    $TITLE"
