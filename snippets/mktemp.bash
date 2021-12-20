#!/usr/bin/env bash
# DESCRIPTION: Automatically clean up temp files
tmpdir="$(mktemp -d)"
function finish {
	rm -rf "$tmpdir"
}
trap finish EXIT
