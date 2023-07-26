#!/usr/bin/env bash
print-run brew install pass || exit $?
print-run brew install pass-otp || exit $?

