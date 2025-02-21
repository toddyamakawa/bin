#!/usr/bin/env python3
# USAGE: ./pipe.py
# DESCRIPTION: Example for piping a string into a command

import subprocess

my_string = "Hello, world!"

with subprocess.Popen(['tr', '[:lower:]', '[:upper:]'], stdin=subprocess.PIPE, stdout=subprocess.PIPE) as process:
    output, error = process.communicate((my_string + '\n').encode())
    print(output.decode())

