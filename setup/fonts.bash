#!/usr/bin/env bash
print-run brew tap homebrew/cask-fonts || exit $?
print-run brew install --cask font-hack-nerd-font || exit $?
print-run brew install --cask font-fira-code-nerd-font || exit $?

