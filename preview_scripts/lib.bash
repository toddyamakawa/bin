#!/usr/bin/env bash

# TODO: Figure out how to get number of lines in fzf preview window
# `tput lines` returns full fzf size
#lines=$(tput lines)
width=$(tput cols)
function cutw() {
	cut -c 1-$width
}
function headn() {
	local n=$1
	shift
	head -n $n $@ | cutw
}
function tailn() {
	local n=$1
	shift
	tail -n $n $@ | cutw
}

# grep things and print in color
esc=$(printf '\033')
function colorgrep() {
	local color="$1"
	shift
	sed \
		-e "s/^/${esc}[${color}m/" \
		-e "s/\$/${esc}[0m/" \
		"$@"
}

