#!/usr/bin/sh

SCREENSHOT="/home/AH/Libraries/Pictures/screenshots/$(date +"%F-%s").png"
maim -s $SCREENSHOT -q -l -c 2.5,2.5,2.5,0.1
xclip -selection clipboard -t image/png $SCREENSHOT
