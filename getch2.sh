#!/usr/bin/env bash

ESCAPE_CHAR=$(printf '\033')

# https://github.com/tom-on-the-internet/shell-snake/blob/main/examples/input
# sets the terminal to not echo input
# and to only wait for $TURN_DURATION tenths of a second
# when waiting for input.
stty -icanon -echo time 20 min 0

function getkey() {
	REPLY="$(dd bs=1 count=1 2> /dev/null)"
	RETVAL=$?
	echo "$REPLY"
	return $RETVAL
}

while true; do
	key="$(getkey)"

	# TODO: Figure out how to handle <ESC> key
	if [[ "$key" == $'\e' ]]; then
		key+="$(getkey)"
		key+="$(getkey)"
	fi

	case "$key" in
		# Arrow keys
		$'\e[A') echo 'up'    ;;
		$'\e[B') echo 'down'  ;;
		$'\e[C') echo 'left'  ;;
		$'\e[D') echo 'right' ;;
		$'\0a' ) echo 'enter' ;;
		' '    ) echo 'space' ;;
		$'\t'  ) echo 'tab'   ;;
		q) echo "q"; exit ;;
		*) echo "$key" ;;
	esac

done

