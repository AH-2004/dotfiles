#!/usr/bin/sh

BAT0=$(upower -e | grep "BAT0")
INFO=$(upower -i $BAT0 | grep "percentage" | tr -d [:space:])
echo "${INFO##*:}"
