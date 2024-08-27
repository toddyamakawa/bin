#!/usr/bin/env bash
# DESCRIPTION: How to use redirection
exec 3>&1 1>&2
exec &> >(tee -a output.log)
