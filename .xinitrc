#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
userprofile=$HOME/.xprofile
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f $userprofile ] && [ "$1" != "xpra" ]; then
	$userprofile
	export XDG_SESSION_DESKTOP=dwm
else
	xpra attach --desktop-scaling=auto ssh://AH@IP:22/1 &
fi

export XDG_SESSION_TYPE=x11

case $1 in	
	dwm ) exec dwm;;
	* ) exec dwm;;
esac
