#!/usr/bin/env bash
# DESCRIPTION: Get script directory
declare -r CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
