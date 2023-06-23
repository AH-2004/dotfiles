#!/usr/bin/sh

BAT="BAT0"

INFO=$(upower -i $(upower -e | grep $BAT))

if [[ "$INFO" == "" ]]; then
	echo "";
	exit
fi

PERCENTAGE=$(awk '/percentage/ { sub(/%/, "", $2); print $2 }' <<< $INFO)
STATE=$(awk '/state/ { print $2 }' <<< $INFO)

ICONS=("" "" "" "" "" "" "" "" "")
ICON_IDX=4

if [[ "$STATE" != "discharging" ]]; then
	ICON_IDX=8
else
	[[ $PERCENTAGE -le 14 ]] && ICON_IDX=0
	[[ $PERCENTAGE -ge 28 ]] && ICON_IDX=1
	[[ $PERCENTAGE -ge 42 ]] && ICON_IDX=2
	[[ $PERCENTAGE -ge 56 ]] && ICON_IDX=3
	[[ $PERCENTAGE -ge 70 ]] && ICON_IDX=4
	[[ $PERCENTAGE -ge 84 ]] && ICON_IDX=5
	[[ $PERCENTAGE -ge 98 ]] && ICON_IDX=6
	[[ $PERCENTAGE -eq 100 ]] && ICON_IDX=7
fi

echo " ${ICONS[$ICON_IDX]}" "$PERCENTAGE |"
