#!/usr/bin/sh

help () {
	echo -e "    Usage:\n        windowctl [option]\n"
	echo "    Options:"
	echo -e "        -h, --help\n            This help dialog"
	echo -e "        -c, --close\n            Close active window"
	echo -e "        -min, --minimize\n            Minimize active window"
	echo -e "        -max, --maximize\n            Maximize active window"
	echo -e "        -tog, --toggle\n            Toggle Maximize state of active window"
	echo -e "        -t, --title\n            Get active window title"
	echo -e "        -p, --pid\n            Get active window pid"
}

case $1 in
	--help | -h)
		help
		;;
	--close | -c)
		xdotool getactivewindow windowclose
		;;
	--minimize | -min)
		xdotool getactivewindow windowminimize
		;;
	--maximize | -max)
		xdotool getactivewindow windowstate MAXIMIZED_VERT windowstate MAXIMIZED_HORZ
		;;
	--toggle | -tog)
		xdotool getactivewindow windowstate --toggle MAXIMIZED_VERT windowstate --toggle MAXIMIZED_HORZ
		;;
	--title | -t)
		echo $(xdotool getactivewindow getwindowname)
		;;
	--pid | -p)
		echo $(xdotool getactivewindow getwindowpid)
		;;
	*)
		help
		;;
esac
