#!/usr/bin/bash

emacs_run() {
	if [ "$DISPLAY" == "" ] || [ "$1" == "-t" ] || [ "$1" == "--tty" ]; then
		emacsclient -nw -a "vim" "$@"
	elif [ "$1" == "-n" ]; then
		emacsclient -n -c -a "vim" "$@"
	else
		emacsclient -n -r -a "vim" "$@"
	fi
}

# Initalize projects
init_c() { mkdir -p "./$1" && cp -r "$HOME/code/c/_template"/* "./$1"; }
init_cpp() { mkdir -p "./$1" && cp -r "$HOME/code/cpp/_template"/* "./$1"; }
init_asm() { mkdir -p "./$1" && cp -r "$HOME/code/assembly/_template"/* "./$1"; }

# Drawpad
map_drawpad() {
	id=$(xsetwacom --list devices | grep "stylus" | awk '{ print $5 }')
	area=$(xwininfo | grep "geometry" | awk '{ print $2 }')
	xsetwacom --set $id MapToOutput "$area"
}

rotate_drawpad() {
	drawpadId=$(xsetwacom --list devices | grep "stylus" | awk '{ print $5 }')
	drawpadRotate=$(xsetwacom --get $drawpadId Rotate)

	if [[ "$drawpadId" == "" ]]; then
		return
	fi
	
	if [[ "$drawpadRotate" == "none" ]]; then
		xsetwacom --set $drawpadId Rotate ccw
	else
		xsetwacom --set $drawpadId Rotate none
	fi
}

remap_drawpad() {
	id=$(xsetwacom --list devices | grep "Pad pad" | awk '{ print $6 }')
	xsetwacom --set $id Button 15 "key del"
}

# Toggle touchscreen
toggle_touch() {
	id=$(xinput list --id-only "ELAN Touchscreen")
	enabled=$(xinput list-props $id | grep 186 | awk '{ print $4 }')
	if [[ "$enabled" == "1" ]]; then
		xinput disable $id
	else
		xinput enable $id
	fi
}

# Toggle scroll method
toggle_scroll() {
	id=$(xinput list --id-only "Synaptics TM3381-002")
	method=$(xinput list-props $id | grep 332 | awk '{ print $6 $7 $8 }')
	if [[ "$method" == "0,1,0" ]]; then
		xinput set-prop $id 332 1 0 0
		xinput set-prop $id 327 1
	else
		xinput set-prop $id 332 0 1 0
		xinput set-prop $id 327 0
	fi
}

# Toggle screen rotation
toggle_rotate() {
	defaultMatrix="1.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,1.000000"
	orientation=$(xrandr --query --verbose | grep eDP1 | awk '{ print $6 }')
	touchscreenId=$(xinput list --id-only "ELAN Touchscreen")
	touchscreenMatrix=$(xinput list-props $touchscreenId | grep 188 | awk '{ print $5 $6 $7 $8 $9 $10 $11 $12 $13 }')
	touchpadId=$(xinput list --id-only "Synaptics TM3381-002")
	touchpadMatrix=$(xinput list-props $touchpadId | grep 188 | awk '{ print $5 $6 $7 $8 $9 $10 $11 $12 $13 }')

	if [[ "$orientation" == "normal" ]]; then
		xrandr --output eDP1 --rotate right
		feh --no-fehbg --bg-scale "/home/AH/libraries/pictures/$BACKGROUND"
	else
		xrandr --output eDP1 --rotate normal
		feh --no-fehbg --bg-scale "/home/AH/libraries/pictures/$BACKGROUND"
	fi

	if [[ "$touchscreenMatrix" == "$defaultMatrix" ]]; then
		xinput set-prop $touchscreenId 188 0 1 0 -1 0 1 0 0 1
	else
		xinput set-prop $touchscreenId 188 1 0 0 0 1 0 0 0 1
	fi

	if [[ "$touchpadMatrix" == "$defaultMatrix" ]]; then
		xinput set-prop $touchpadId 188 0 1 0 -1 0 1 0 0 1
	else
		xinput set-prop $touchpadId 188 1 0 0 0 1 0 0 0 1
	fi

	xinput map-to-output $touchscreenId eDP1
	rotate_drawpad
}

reset_rotate() {
	defaultMatrix="1.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,1.000000"
	orientation=$(xrandr --query --verbose | grep eDP1 | awk '{ print $6 }')
	touchscreenId=$(xinput list --id-only "ELAN Touchscreen")
	touchpadId=$(xinput list --id-only "Synaptics TM3381-002")
	drawpadId=$(xsetwacom --list devices | grep "stylus" | awk '{ print $5 }')
	touchscreenMatrix=$(xinput list-props $touchscreenId | grep 188 | awk '{ print $5 $6 $7 $8 $9 $10 $11 $12 $13 }')
	touchpadMatrix=$(xinput list-props $touchpadId | grep 188 | awk '{ print $5 $6 $7 $8 $9 $10 $11 $12 $13 }')
	drawpadRotate=$(xsetwacom --get $drawpadId "Rotate")
	
	if [[ "$orientation" != "normal" ]]; then
		xrandr --output eDP1 --rotate normal
		feh --no-fehbg --bg-scale "/home/AH/libraries/pictures/background.png"
	fi

	if [[ "$touchscreenMatrix" != "$defaultMatrix" ]]; then
		xinput set-prop $touchscreenId 188 1 0 0 0 1 0 0 0 1
	fi

	if [[ "$touchpadMatrix" != "$defaultMatrix" ]]; then
		xinput set-prop $touchpadId 188 1 0 0 0 1 0 0 0 1
	fi

	if [[ "$drawpadRotate" != "none" && "$drawpadId" != "" ]]; then
		xsetwacom --set $drawpadId Rotate none
	fi

	xinput map-to-output $touchscreenId eDP1
}

refresh_background() {
	feh --no-fehbg --bg-scale "/home/AH/libraries/pictures/$BACKGROUND"
}

toggle_nightmode() {
	temp=4500
	currentTemp=$(xsct | awk '{ print $5 }')

	if [[ "$currentTemp" != "6500" ]]; then
		xsct 6500
	else
		xsct $temp	
	fi	
}

toggle_midnightmode() {
	backlight=$(light -G)
	minimumBacklight=$(light -P)
	
	if [[ "$backlight" != "$minimumBacklight" ]]; then
		light -O
		light -S $minimumBacklight
	else
		light -I
	fi
	
	toggle_nightmode
}

media_playpause() {
	mocp -G || playerctl play-pause
}

media_next() {
	mocp -f || playerctl next
}

media_previous() {
	mocp -r || playerctl previous
}

inc_volume() {
	pactl set-sink-volume @DEFAULT_SINK@ +5%
	~/.config/scripts/volume_bar.sh
}

dec_volume() {
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	~/.config/scripts/volume_bar.sh
}

mute_volume() {
	pactl set-sink-mute @DEFAULT_SINK@ toggle
}

inc_backlight() {
	light -A 5
	~/.config/scripts/backlight_bar.sh
}

dec_backlight() {
	light -U 5
	~/.config/scripts/backlight_bar.sh
}

# The following case block is to allow these functions
# to be accessable from the shell.
case $1 in
	emacs_run)
		emacs_run
		;;
	init_c)
		init_c
		;;
	init_cpp)
		init_cpp
		;;
	map_drawpad)
		map_drawpad
		;;
	rotate_drawpad)
		rotate_drawpad
		;;
	remap_drawpad)
		remap_drawpad
		;;
	toggle_touch)
		toggle_touch
		;;
	toggle_scroll)
		map_drawpad
		;;
	toggle_rotate)
		toggle_rotate
		;;
	reset_rotate)
		reset_rotate
		;;
	refresh_background)
		refresh_background
		;;
	toggle_nightmode)
		toggle_nightmode
		;;
	toggle_midnightmode)
		toggle_midnightmode
		;;
	media_playpause)
		media_playpause
		;;
	media_next)
		media_next
		;;
	media_previous)
		media_previous
		;;
	inc_volume)
		inc_volume
		;;
	dec_volume)
		dec_volume
		;;
	mute_volume)
		mute_volume
		;;
	inc_backlight)
		inc_backlight
		;;
	dec_backlight)
		dec_backlight
		;;
esac
