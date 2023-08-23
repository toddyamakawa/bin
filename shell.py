#!/usr/bin/env python3

# How to use:
# exec(open('shell.py').read())

def pwd():
    import os
    return os.getcwd()

def ls():
    import os
    return os.listdir(os.getcwd())

def cd(path):
    import os
    return os.chdr(path)

def run(file):
    exec(open(file).read())

def cmd(command):
    import os
    os.system(command)

