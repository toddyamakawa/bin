#!/usr/bin/env bash
# USAGE: ./mkfifo.bash
# DESCRIPTION: Create a FIFO
fifo="$(mktemp -u --suffix=.fifo)"
function cleanup { rm -rf "$fifo"; }
trap cleanup EXIT
(umask 077; mkfifo "$fifo";)
ls -l "$fifo"
