#!/usr/bin/env bash
# DESCRIPTION: Open in nvim

# Remember, when piping xargs don't forget to use -o:
# <cmd> | xargs -o e
if command -v nvim &>/dev/null; then
	exec nvim "$@"
fi
exec vim "$@"
