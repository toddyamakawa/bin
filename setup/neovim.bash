#!/usr/bin/env bash
if (which brew); then
	# https://dev.to/craftzdog/how-to-install-neovim-on-apple-silicon-m1-mac-27ke
	xcode-select --install
	brew install --HEAD tree-sitter
	brew install --HEAD luajit
	brew install --HEAD neovim
else
	sudo apt -y install neovim
fi
