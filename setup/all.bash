#!/usr/bin/env bash

# Install tmux
command -v tmux &>/dev/null || print-run sudo apt install -y tmux
print-run tmux -V || exit $?

# Install nvim
echo
if ! command -v nvim &>/dev/null; then
	print-run sudo apt-get install -y software-properties-common
	print-run sudo add-apt-repository ppa:neovim-ppa/unstable
	print-run sudo apt-get update
	print-run sudo apt-get -y install neovim
fi
print-run nvim --version || exit $?

# Download dotfiles
# echo
config="$HOME/.config"
if ! [[ -f "$config/gitconfig" ]]; then
	mv "$config" "${config}.old"
	print-run git toddky dotfiles "$config"
fi
if ! [[ -f "$config/gitconfig" ]]; then
	print-error "Unable to install dotfiles"
	exit 1
fi




