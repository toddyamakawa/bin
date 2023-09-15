#!/usr/bin/env bash

repo='https://github.com/toddky/bin'
bin="$HOME/bin"

if ! command -v git &>/dev/null; then
	sudo apt install -y git
	type git || exit $?
fi

if ! [[ -d "$bin" ]]; then
	echo git clone https://github.com/toddky/bin "$bin"
	git clone "$repo" "$bin"
fi

if ! [[ -d "$bin" ]] ; then
	echo "Unable to clone $repo"
	exit 1
fi

PATH="$bin:$PATH"
print-cmd "$bin/setup/all.bash"
"$bin/setup/all.bash"

