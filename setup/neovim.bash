#!/usr/bin/env bash
which brew || exit $?
# https://dev.to/craftzdog/how-to-install-neovim-on-apple-silicon-m1-mac-27ke
xcode-select --install
brew install --HEAD tree-sitter
brew install --HEAD luajit
brew install --HEAD neovim
