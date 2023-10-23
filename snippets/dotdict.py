#!/usr/bin/env python3
# USAGE: ./source.py <FILE>
# DESCRIPTION: Example for sourcing a file

# https://stackoverflow.com/questions/2352181/how-to-use-a-dot-to-access-members-of-dictionary
class dotdict(dict):
    __getattr__ = dict.get
    __setattr__ = dict.__setitem__
    __delattr__ = dict.__delitem__

config = dotdict()
config.host = 'localhost'
config.users = dotdict()
config.users.foo = 'bar'
print(config)

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

