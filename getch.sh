#!/usr/bin/env bash

# REVISIT: Another way to do this?
# https://github.com/iruzo/pxmenu/blob/2508ee1200b98b68897618bf3c8e60632f29fdb1/pxmenu#L10

# stty -echo -icanon time 0 min 0

while [[ -z "$key" ]]; do
	key="$(dd bs=1 count=1 2>/dev/null)"
done

next='.'
while [[ -n "$next" ]]; do
	next="$(dd bs=1 count=1 2>/dev/null)"
	key+="$next"
done

case "$key" in

	$'\e'   ) echo 'esc'     ;;
	$'\e[A' ) echo 'up'      ;;
	$'\e[B' ) echo 'down'    ;;
	$'\e[C' ) echo 'left'    ;;
	$'\e[D' ) echo 'right'   ;;
	$'\e[5~') echo 'pageup'  ;;
	$'\e[6~') echo 'pagedown';;

	$'\n'   ) echo 'enter'   ;;
	$'\r'   ) echo 'enter'   ;;

	' '     ) echo 'space'   ;;
	$'\t'   ) echo 'tab'     ;;

	*       ) echo "$key";;
	#*       ) echo -n "$key"  | xxd -p ;;
esac

