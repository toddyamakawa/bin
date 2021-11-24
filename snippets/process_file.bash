#!/usr/bin/env bash
# DESCRIPTION: Process file

# Check usage
declare -r USAGE='USAGE: $0 <input> [output]'
if [[ -z "$1" ]]; then
  echo "$USAGE"
  exit 1
fi

# Check file
if ! [[ -f "$1" ]]; then
  echo "ERROR: File '$1' not found." 1>&2
  exit 2
fi
file_dir="$(dirname "$1")"
file_base="$(basename "$1" .extension)"
output_file="${2:-$file_dir/$file_base.new_extension}"

