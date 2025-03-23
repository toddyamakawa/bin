#!/usr/bin/env bash
[[ -f golang.sif ]] || apptainer pull golang.sif docker://golang:latest
print-cmd apptainer exec --bind "\$PWD/go-cache:/go/pkg" golang.sif bash
