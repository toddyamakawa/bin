#!/usr/bin/env bash

# `cd` using `nnn`
# Taken from here:
# https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
function cdn() {
	if ! (which nnn &>/dev/null); then
		echo "nnn not found"
		return 1
	fi

	# Block nesting of nnn in subshells
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return 1
	fi

	# The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
	# To cd on quit only on ^G, remove the "export" as in:
	#     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	# NOTE: NNN_TMPFILE is fixed, should not be modified
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	# Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
	# stty start undef
	# stty stop undef
	# stty lwrap undef
	# stty lnext undef

	if (which ,nnn &>/dev/null); then
		,nnn "$@"
	else
		nnn "$@"
	fi

	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}

