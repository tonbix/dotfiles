SCREENSHOT_PATH=$1
SLURP_OUTPUT=$2

echo -e "$SCREENSHOT_PATH\n$SLURP_OUTPUT"

echo "${SLURP_OUTPUT}" | awk -F '[,x]' '{print $1, $2, $3, $4}' | {
	read -r XPOS YPOS XREL YREL
	echo $XPOS $YPOS $XREL $YREL

	magick $SCREENSHOT_PATH -crop ${XPOS}x${YPOS}+${XREL}+${YREL} $SCREENSHOT_PATH
}

