#!/usr/bin/env bash
# DESCRIPTION: Automatically clean up temp files
tmpdir=$(mktemp -d -t tmp.XXXXXXXXXX)
function finish {
  rm -rf "$tmpdir"
}
trap finish EXIT
