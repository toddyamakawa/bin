#!/usr/bin/env bash

type python3 || exit $?
type pip || exit $?

# Install QMK
print-run python3 -m pip install --user qmk || exit $?
type qmk || exit $?

# Set up QMK
qmk setup || exit $?

