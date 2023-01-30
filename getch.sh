#!/usr/bin/env bash

printkey=''

function getkey() {
	#read -t 0.5 -srn 1
	read -srn 1
}

while true; do
	getkey
	key="$REPLY"

	if [[ "$key" == $'\e' ]]; then
		getkey
		key+="$REPLY"
		getkey
		key+="$REPLY"
	fi

	case "$key" in
		$'\e[A') echo 'up'    ;;
		$'\e[B') echo 'down'  ;;
		$'\e[C') echo 'left'  ;;
		$'\e[D') echo 'right' ;;
		*) echo "$key" ;;
	esac

done

