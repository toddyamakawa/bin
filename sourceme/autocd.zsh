#!/usr/bin/env zsh
# Write to $zshcd to cd to it

# Check if $zshcd already exists
[[ -r "$zshcd" ]] && return 0

# Create $zshcd file
declare -r zshcd="/tmp/zsh-$(id -u).$$.path"
if [[ ! -r "$zshcd" ]]; then
	(mkfifo "$zshcd")
	touch "$zshcd"
fi
chmod 600 "$zshcd"

# Create $zshpath file
zshpath="$(mktemp --suffix=.zsh-path)"

# Run a background process to watch fifo
{
	while read line; do
		if [[ -d "$line" ]]; then
			echo "$line" > "$zshpath"
			kill -s USR1 $$
		fi
	done < <(tail -f "$zshcd")
} &

# Trap all USR1 signals
TRAPUSR1() {
	local newpath
	[[ -f "$zshpath" ]] || return
	newpath="$(cat $zshpath)"
	[[ -d "$newpath" && "$newpath" != "$(pwd)" ]] || return
	if [[ -o zle ]]; then
		#zle -R && cd "$newpath" && precmd 2>/dev/null && zle reset-prompt 2>/dev/null
		zle -R
		cd "$newpath"
		precmd 2>/dev/null
		zle reset-prompt 2>/dev/null
	fi
}

