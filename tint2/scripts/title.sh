NAME=$(xdotool getactivewindow getwindowname)
PID=$(xdotool getactivewindow getwindowpid)

if [[ $NAME == *"-"* ]]; then
	NAME="${NAME##*- }"
fi

if [[ $1 == "--pid" ]]; then
	echo "$NAME | $PID"
else
	echo "$NAME"
fi
