#!/usr/bin/env bash
name="${1?usage: $0 <session_name>}"
if [[ -e "${TMUX%%,*}" ]]; then
	tmux switch-client -t "$name"
else
	tmux attach -t "$name"
fi
