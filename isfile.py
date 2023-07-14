#!/usr/bin/env python3

import sys
import os

file = sys.argv[1]

print(f'os.path.islink(file): {os.path.islink(file)}')
print(f'os.path.isfile(file): {os.path.isfile(file)}')
print(f'os.path.isdir(file): {os.path.isdir(file)}')
print(f'os.path.exists(file): {os.path.exists(file)}')

