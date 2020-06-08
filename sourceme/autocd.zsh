#!/usr/bin/env zsh
# Write to $zshcd to cd to it

# Create $zshcd file
zshcd="/tmp/zsh-$(id -u).$$.path"
if [[ ! -r "$zshcd" ]]; then
	(mkfifo "$zshcd")
	touch $zshcd
fi
chmod 600 $zshcd

# Create $zshpath file
zshpath="$(mktemp --suffix=.zsh-path)"

# Run a background process to watch fifo
{
	while read line; do
		if [[ -d "$line" ]]; then
			echo "$line" > $zshpath
			kill -s USR1 $$
		fi

	done < <(tail -f $zshcd)
} &

# Trap all USR1 signals
TRAPUSR1() {
	if [[ -f "$zshpath" ]]; then
		newpath="$(cat $zshpath)"
		if [[ -d "$newpath" && "$newpath" != "$(pwd)" && -o zle ]]; then
			zle -R && cd "$newpath" && precmd && zle reset-prompt 2>/dev/null
		fi
	fi
}

