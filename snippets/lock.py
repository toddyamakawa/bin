#!/usr/bin/env python3
# USAGE: ./lock.py <FILE>
# DESCRIPTION: Example for locking a file

import os
import sys

from flufl.lock import Lock
from flufl.lock._lockfile import NotLockedError

lockfile = sys.argv[1]
locknum = sys.argv[2]

script_dir = os.path.dirname(__file__)
locked_file = f'{script_dir}/file.txt'
lock = Lock(lockfile)

with Lock(lockfile) as lock:
    with open(locked_file, 'a') as f:
        f.write(f'{locknum}\n')

