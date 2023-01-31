#!/usr/bin/env bash

# Information:
# - https://carlosbecker.com/posts/ssh-tips-and-tricks/

# Set permissions
umask 077

# Check SSH directory
SSH_DIR="$HOME/.ssh"
if [[ -d "$SSH_DIR" ]]; then
	echo -e "\e[31;1mWARNING: '$SSH_DIR' already exists!\e[0m"
	yesno "Do you wish to continue?" || exit $?
	echo "Moving '$SSH_DIR' to '$SSH_DIR.backup'..."
	mv "$SSH_DIR" "$SSH_DIR.backup"
fi
mkdir -pv "$SSH_DIR"

# Generate SSH key
echo "Generating key..."
ssh-keygen -f "$SSH_DIR/id_rsa" -N ""
cp $SSH_DIR/id_rsa.pub $SSH_DIR/authorized_keys

# SSH config
echo "Generating $SSH_DIR/config file..."
cat >$SSH_DIR/config << SSH_CONFIG
Host *
	ForwardAgent yes
	ForwardX11 yes
	ServerAliveInterval 120
	StrictHostKeyChecking no

Host example.org
	RemoteCommand tmux new -A -s default

	ControlMaster  auto
	ControlPath    /tmp/%r@%h:%p.ssh
	ControlPersist yes

Host localhost
	UserKnownHostsFile /dev/null
	StrictHostKeyChecking no

Host charm
	HostName git.charm.sh
SSH_CONFIG

# Fix home directory permissions
chmod +x $HOME
chmod g-w $HOME

# Skip testing for now
exit 0

# Hope this works
echo
echo 'Testing ssh...'
echo "$> ssh $(hostname --long) hostname --long"
if ! (ssh -q -o "BatchMode=yes" -o "ConnectTimeout=3" "$(hostname)" "hostname --long"); then
	echo 'FAILED!'
fi

