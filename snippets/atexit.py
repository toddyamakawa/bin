#!/usr/bin/env python3
# USAGE: ./atexit.py
# DESCRIPTION: atexit example

import atexit
from time import sleep

def goodbye(name):
    print()
    print(f'Goodbye {name}')

atexit.register(goodbye, 'Todd')

print('Sleeping for 10 seconds... kill with Ctrl-C')
sleep(10)

