#!/usr/bin/sh

SCREENSHOT="/home/AH/libraries/pictures/screenshots/$(date +"%F-%s").png"
maim -s $SCREENSHOT -q -l -c 0.75,0.65,0.76,0.1
xclip -selection clipboard -t image/png $SCREENSHOT
