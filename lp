#!/usr/bin/env bash

# ==============================================================================
# CHECK
# ==============================================================================
# LastPass CLI
# https://github.com/lastpass/lastpass-cli
if ! (which lpass &> /dev/null); then
	exitfail lpass not found
	echo
	if (is-macos); then
		echo brew update
		echo brew install lastpass-cli
	else
		echo sudo apt install -y lastpass-cli
	fi
	exit 1
fi


# ==============================================================================
# ENVIRONMENT
# ==============================================================================

# https://manpages.debian.org/testing/lastpass-cli/lpass.1.en.html

# --format
# %ai: account id
# %an: account name
# %aN: account name including path
# %au: account user
# %ap: account password
# %am: account modification time
# %aU: account last touch time
# %as: account share name
# %ag: account group name
# %al: account URL
# %fn: field name (for show)
# %fv: field value (for show)


# --- Environment ---
# An agent process handle commands for the user without asking for a password.
# $LPASS_AGENT_TIMEOUT environment variable
# - Agents quits after one hour if not set
# - Agent never quits if set to 0
# - Agent quits after number of seconds if set
export LPASS_AGENT_TIMEOUT=0

# The agent is disabled if $LPASS_AGENT_DISABLE is set to 1
unset LPASS_AGENT_DISABLE

# Commands that support -c or --clip copies output using
# - xclip(1) or xsel(1) on X11-based systems
# - pbcopy(1) on OSX
# - putclip on Cygwin.
# Clipboard command an be overridden by $LPASS_CLIPBOARD_COMMAND
unset LPASS_CLIPBOARD_COMMAND

# Use CLI to enter password
export LPASS_DISABLE_PINENTRY=1


# ==============================================================================
# RUN
# ==============================================================================
exec lpass $@

