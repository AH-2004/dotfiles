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
	id=$(xsetwacom --list devices | grep "STYLUS" | awk '{ print $5 }')
	area=$(xwininfo | grep "geometry" | awk '{ print $2 }')
	xsetwacom --set $id MapToOutput "$area"
}

rotate_drawpad() {
	id=$(xsetwacom --list devices | grep "STYLUS" | awk '{ print $5 }')
	rotate=$(xsetwacom --get $id "Rotate")
	if [[ "$rotate" == "none" ]]; then
		xsetwacom --set $id "Rotate" "ccw"
	else
		 xsetwacom --set $id "Rotate" "none"
	fi
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
toggle_scrolling() {
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
