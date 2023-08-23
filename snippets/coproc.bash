#!/usr/bin/env bash
# DESCRIPTION: How to use a coproc
coproc coproc_name { read -r input; echo "coproc input '$input'"; }
echo "read this" >&"${coproc_name[1]}"
read -r output <&"${coproc_name[0]}"
echo "output: $output"
