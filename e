#!/usr/bin/env bash
# DESCRIPTION: Open in nvim
if command -v nvim &>/dev/null; then
	exec nvim "$@"
fi
exec vim "$@"
