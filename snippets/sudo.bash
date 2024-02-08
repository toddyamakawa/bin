#!/usr/bin/env bash
# DESCRIPTION: Keep sudo alive until script is done

# Ask for for password
sudo -v

# Kepp sudo alive until script is done
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

