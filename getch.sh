#!/usr/bin/env bash

# REVISIT: Another way to do this?
# https://github.com/iruzo/pxmenu/blob/2508ee1200b98b68897618bf3c8e60632f29fdb1/pxmenu#L10

function getkey() {
	#read -t 0.5 -srn 1
	read -srn 1
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

