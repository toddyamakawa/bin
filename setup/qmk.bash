#!/usr/bin/env bash

type python3 || exit $?
type pip || exit $?

print-run python3 -m pip install --user qmk

