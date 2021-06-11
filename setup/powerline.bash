#!/usr/bin/env bash
which brew || exit $?
# https://gist.github.com/nvictor/3882b8426ef59d73fbb5b85c70b5097c
brew tap homebrew/cask-fonts
brew install --cask font-consolas-for-powerline

