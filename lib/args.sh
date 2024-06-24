#!/usr/bin/env bash
# USAGE: source /path/to/args.sh
# DESCRIPTION: Library for parsing args

HELP=''
declare -A FLAGS
declare -A FLAGS_TYPE

function DEFINE_int() {
	[[ -z "$1" ]] && return

	#if [[ "$1" =~ .*--([-a-z]+).* ]]; then
		#echo "${BASH_REMATCH[1]}"
	#elif [[ "$1" =~ '-(\w)' ]]; then
		#echo "${BASH_REMATCH[1]}"
	#else
		#echo "fail"
		#exit 1
	#fi

	FLAGS["$1"]="$3"
	FLAGS_TYPE["$1"]='int'

	HELP+="$(printf '    %-21s %s' "$1" "$2")\n"
}

function PARSE() {
	local _arg
	local _flag
	local _flags
	local _match

	while [[ $# -ge 1 ]]; do
		_arg="$1" && shift

		# Look for match in $FLAGS
		_match=''
		for _flags in "${!FLAGS[@]}"; do
			for _flag in ${_flags[@]//,/ }; do
				[[ "$_arg" == "$_flag" ]] || continue
				_match="$_flags"
			done
			[[ -n "$_match" ]] && break
		done

		# Check if argument is valid
		if [[ -z "$_match" ]]; then
			printf "\033[0;31;1mERROR: Unknown argument '%s'\033[0m\n" "$_arg"
			exit 1
		fi

		# Check argument type
		case "${FLAGS_TYPE["$_match"]}" in
			int)
				if ! [[ "$1" =~ ^[0-9]+$ ]]; then
					printf "\033[0;31;1mERROR: Invalid integer '%s' for '%s'\033[0m\n" "$1" "$_arg"
					exit 1
				fi
				FLAGS["$_match"]="$1"
				shift
				;;
			*)
				printf "\033[0;31;1mERROR: Unknown type '%s'\033[0m\n" "${FLAGS_TYPE["$_match"]}"
				exit 1
				;;
		esac

		# REVISIT: Finish this
		for _flags in "${!FLAGS[@]}"; do
			if [[ "$_flags" =~ .*--([-a-z]+).* ]]; then
				echo "match ${BASH_REMATCH[1]}"
				exit
			elif [[ "$_flags" =~ '-(\w)' ]]; then
				echo "match ${BASH_REMATCH[1]}"
				exit
			else
				echo "fail"
				exit 1
			fi
		done

	done
}

function print_help() {
	echo "options:"
	echo -e "$HELP"
}

