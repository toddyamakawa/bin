#!/usr/bin/env bash
# https://code.visualstudio.com/blogs/2020/12/03/chromebook-get-started
set -e

echo
print-header 'Golang'
print-run sudo add-apt-repository ppa:longsleep/golang-backports || exit $?
print-run sudo apt update || exit $?
print-run sudo apt install -y golang-go || exit $?

echo
print-header 'Hugo'
print-run sudo apt install -y hugo

