#!/usr/bin/sh

if pgrep -x plank
then
	pkill plank
else
	setsid plank &> /dev/null
fi
