#!/usr/bin/env bash
# https://code.visualstudio.com/blogs/2020/12/03/chromebook-get-started
set -e

print-header 'Install'
print-cmd sudo apt-get update
sudo apt-get update
print-cmd sudo apt-get install -y gnome-keyring
sudo apt-get install -y gnome-keyring

echo
print-header 'Download'
echo -n "Go here:"
print-url https://code.visualstudio.com/download
print-cmd dpkg --print-architecture
dpkg --print-architecture

echo
print-header 'JavaScript/Node.js'
echo 'To use JavaScript/Node.js, run:'
print-cmd 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash'
print-cmd 'source .bashrc'
print-cmd 'nvm install node'

echo
print-header 'Python'
echo 'To use Python, run:'
print-cmd 'sudo apt-get install -y python3-pip python3-dev python3-venv build-essential libssl-dev libffi-dev'

