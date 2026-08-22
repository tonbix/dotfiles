wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F ' ' '{print $2, $3}' | {
	read -r VOLUME MUTE_STATUS

	VOLUME=$(echo "$VOLUME" | sed -e 's/[^0-9]//g' -e 's/0*//')
	
	if [ -z "$VOLUME" ]; then
		VOLUME=0
	fi

	if [ -z "$MUTE_STATUS" ]; then
		notify-send "volume: $VOLUME" -u low -h int:value:$VOLUME -c VOLUME-CONTROL
	else
		notify-send "[MUTED] volume: $VOLUME" -u low -h int:value:$VOLUME -c VOLUME-CONTROL
	fi
}

