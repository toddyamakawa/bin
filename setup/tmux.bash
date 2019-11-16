#!/usr/bin/env bash
TMUX_VERSION=3.0
tmp_tmux=/tmp/tmux

# https://github.com/tmux/tmux/blob/master/CHANGES

# Immediately exit on failure
set -e

# Always run when script finishes
function finish() {
	local RETVAL=$?
	echo -e "path: $here\ncommand: $@\nexit: $RETVAL"
}
eval trap "'finish $0 $@'" EXIT

# Install dependencies
sudo apt update
sudo apt install -y \
	automake \
	bison \
	build-essential \
	byacc \
	pkg-config \
	libevent-dev \
	libncurses5-dev

# Install tmux
if [[ ! -d "$tmp_tmux" ]]; then
	git clone https://github.com/tmux/tmux.git $tmp_tmux
fi
cd $tmp_tmux
git checkout $TMUX_VERSION

sh autogen.sh
./configure && make
sudo make install

