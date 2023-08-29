#!/usr/bin/env python3
# USAGE: ./source.py <FILE>
# DESCRIPTION: Example for sourcing a file

# https://github.com/nicholasmireles/DotDict

try:
    from dotdict import DotDict as dd
except ImportError:
    print("ERROR: dotdict.py not found")
    print("run: pip install attr-dot-dict")
    exit(1)

config = dd()
config.host = 'localhost'
config.users.foo = 'bar'
print(config)

