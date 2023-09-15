#!/usr/bin/env bash

repo='https://github.com/toddky/bin'
bin="$HOME/bin"

if ! [[ -d "$bin" ]] ; then
	sudo apt install -y git
	which git || exit $?
	echo git clone https://github.com/toddky/bin "$bin"
	git clone "$repo" "$bin"
fi

if ! [[ -d "$bin" ]] ; then
	echo "Unable to clone $repo"
	exit 1
fi

PATH="$bin:$PATH"
"$bin/setup/all.bash"

