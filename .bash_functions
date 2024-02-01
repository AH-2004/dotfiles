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
init_c() { mkdir -p "./$1" && cp -r "$HOME/code/c/makefile_template"/* "./$1"; }
init_cpp() { mkdir -p "./$1" && cp -r "$HOME/code/cpp/makefile_template"/* "./$1"; }

# Drawpad
map_drawpad() {
	id=$(xsetwacom --list devices | grep "stylus" | awk '{ print $5 }')
	area=$(xwininfo | grep "geometry" | awk '{ print $2 }')
	xsetwacom --set $id MapToOutput "$area"
}

rotate_drawpad() {
	id=$(xsetwacom --list devices | grep "stylus" | awk '{ print $5 }')
	rotate=$(xsetwacom --get $id "Rotate")
	if [[ "$rotate" == "none" ]]; then
		xsetwacom --set $id Rotate ccw
	else
		 xsetwacom --set $id Rotate none
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
		xrandr --orientation right
	else
		xrandr --orientation normal
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

	rotate_drawpad
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
	toggle_nightmode)
		toggle_nightmode
		;;
	toggle_midnightmode)
		toggle_midnightmode
		;;
esac
