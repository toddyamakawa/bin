#!/usr/bin/env bash
# DESCRIPTION: Parse arguments
declare -A ARGV
declare -a ARGS
while [[ $# -ge 1 ]]; do
	arg="$1" && shift
	case "$arg" in
		-*) [[ $1 == ${1#-} ]] && { ARGV["$arg"]="$1"; shift; } || ARGV["$arg"]=1;;
		*) ARGS=("${ARGS[@]}" "$arg");;
	esac
done
