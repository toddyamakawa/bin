#!/usr/bin/env bash
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

