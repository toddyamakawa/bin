#!/usr/bin/env bash
# Run tmux-cmd if valid
if command -v "i3-$1" &>/dev/null; then
	SUPERCMD=i3 exec "i3-$@"
fi
exec i3 "$@"
