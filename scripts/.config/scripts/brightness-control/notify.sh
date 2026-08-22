BRIGHTNESS=$(brillo)
BRIGHTNESS=${BRIGHTNESS%%.*}

notify-send "brightness: $BRIGHTNESS" -u low -i NONE -h int:value:$BRIGHTNESS -r 10001

