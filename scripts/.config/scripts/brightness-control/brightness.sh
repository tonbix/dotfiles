STEP=5

if [ $1 == "increase" ]; then
	sudo brillo -A $STEP
elif [ $1 == "decrease" ]; then
	sudo brillo -U $STEP
else
	echo "Unrecognized parameter: ${1}"
	echo "Usage should be: brightness.sh <increase|decrease>"
fi

~/.config/scripts/brightness-control/notify.sh

