STEP=5

if [ $1 == "increase" ]; then
	wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ $STEP%+
elif [ $1 == "decrease" ]; then
	wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ $STEP%-
elif [ $1 == "mute" ]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
	echo "Unrecognized parameter: ${1}"
	echo "Usage should be: volume.sh <increase|decrease|mute>"
fi

~/.config/scripts/volume-control/notify.sh

