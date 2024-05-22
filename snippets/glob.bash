#!/usr/bin/env bash
# USAGE: ./glob.bash
# DESCRIPTION: Check if a glob exists

glob='*.py'

first_match="$(find . -maxdepth 1 -name "$glob" -print -quit)"
echo "first match: $first_match"

compgen -G "$glob" &>/dev/null && echo 'match found' || echo 'match not found'

