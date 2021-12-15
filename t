#!/usr/bin/env bash
# Run tmux-cmd if valid
if command -v "tmux-$1" &>/dev/null; then
	SUPERCMD=tmux exec supercmd "$@"
fi
exec tmux "$@"
