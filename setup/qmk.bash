#!/usr/bin/env bash

print-url 'https://docs.qmk.fm/#/newbs_getting_started?id=set-up-qmk'
echo

type python3 || exit $?
type pip || exit $?

# Install QMK
print-run python3 -m pip install --user qmk || exit $?
type qmk || exit $?

# Set up QMK
qmk setup || exit $?

