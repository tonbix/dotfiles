SCREENSHOT_PATH=~/Pictures/screenshots/$(date +'%s.png')

if [ $1 == "output" ]; then
	OUTPUT=$(hyprctl -j activeworkspace | jq -r ".monitor")
	grim -o $OUTPUT -c $SCREENSHOT_PATH
elif [ $1 == "selection" ]; then
	wayfreeze & PID=$!

	trap "kill $PID 2>/dev/null" EXIT

	sleep .1;

	GEOMETRY=$(~/.config/scripts/screenshots/slurp.sh)

	sleep .15;

	if [ ! -z "$GEOMETRY" ]; then
		echo "screenshoted"
		grim -c -g "$GEOMETRY" $SCREENSHOT_PATH
	else
		echo "screenshot aborted: no geometry provided"
		notify-send -u low "screenshot aborted" "selection cancelled" -i None
		exit
	fi
elif [ $1 == "activewindow" ]; then
	PADDING=12

	WINDOW_DATA=$(hyprctl -j activewindow)
	
	if [ "$(echo "$WINDOW_DATA" | jq -r '.at')" != "null" ] && [ "$(echo "$WINDOW_DATA" | jq -r '.at[0]')" != "null" ]; then
		
		GEOMETRY=$(echo "$WINDOW_DATA" | jq -r --argjson pad "$PADDING" '
			(.at[0] - $pad | tostring) + "," + (.at[1] - $pad | tostring) + " " + 
			(.size[0] + $pad * 2 | tostring) + "x" + (.size[1] + $pad * 2 | tostring)
		')

		echo "screenshoted"
		grim -c -g "$GEOMETRY" $SCREENSHOT_PATH
	else
		echo "screenshot aborted: no active window"
		notify-send -u low "screenshot aborted" "no active window" -i None
		exit
	fi
elif [ $1 == "activewindow" ]; then
	GEOMETRY=$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

	if [ "$GEOMETRY" != "null,null nullxnull" ]; then
		echo "screenshoted"
		grim -c -g "$GEOMETRY" $SCREENSHOT_PATH
	else
		echo "screenshot aborted: no active window"
		notify-send -u low "screenshot aborted" "no active window" -i None
		exit
	fi
else
	echo "Unrecognized parameter: ${1}"
	echo "Usage should be: screenshot.sh <output|selection|activewindow>"
	exit
fi

if [ -f $SCREENSHOT_PATH ]; then
	wl-copy < $SCREENSHOT_PATH

    (
        ACTION=$(notify-send "captured screenshot" "$SCREENSHOT_PATH" -u low -i $SCREENSHOT_PATH --action="default=open")

        if [ "$ACTION" = "default" ]; then
            xdg-open "$SCREENSHOT_PATH"
            echo "opening screenshot"
        fi
    ) &
fi

