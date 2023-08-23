#!/usr/bin/env bash
# DESCRIPTION: Write current script to a log file
now="$(date +'%Y%m%d-%H%M%S')"
log="logs/$now.log"
mkdir -p "$(dirname "$log")"
exec &> >(tee -a "$log")
