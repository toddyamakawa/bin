#!/usr/bin/env bash
print-run sudo apt update
print-run sudo apt -y install apache2
# Automatically starts after installing
print-run sudo systemctl status apache2
