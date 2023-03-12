#!/usr/bin/sh
TEMPS=$(~/.config/tint2/scripts/temps.sh)
MEDIA=$(playerctl -i chromium metadata --format '{{title}}')
TITLE=$(~/.config/tint2/scripts/window.sh --name)
TIME=$(date +'%r')
DATE=$(date +'%A %B %d %Y')
SSID=$(~/.config/tint2/scripts/ssid.sh)
echo "$TIME  $MEDIA"
echo "$DATE  $TEMPS  $SSID  $TITLE"
