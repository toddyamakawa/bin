#!/usr/bin/env python3

import os
import subprocess
import sys

HOME = os.environ['HOME']

# Your command as a list of strings
sys.argv.pop(0)
command = sys.argv

print(f'command: {command}')

print()
print('stdout:')
completed_process = subprocess.run(
    command,
    stderr=subprocess.PIPE,
    universal_newlines=True  # Capture output as text
)

print()
print(f'returncode: {completed_process.returncode}')

# Print stderr
print("stderr:", file=sys.stderr)
print(completed_process.stderr, file=sys.stderr)

