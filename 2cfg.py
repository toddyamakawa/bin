#!/usr/bin/env python3
import argparse
import sys
import yaml

parser = argparse.ArgumentParser()
parser.add_argument('input', nargs='?', type=argparse.FileType(), default=sys.stdin)
args = parser.parse_args()

info = yaml.safe_load(args.input)
#print(yaml.dump(info, indent=2))

def to_cfg_list(info, parent=''):
    config = []
    for index, value in enumerate(info):
        config += to_cfg(value, f'{parent}[{index}]')
    return config

def to_cfg_dict(info, parent=''):
    if parent: parent = f'{parent}.'
    config = []
    for key, value in sorted(info.items()):
        config += to_cfg(value, f'{parent}{key}')
    return config

def to_cfg(info, parent = ''):
    if(info == None):
        return [f"{parent}="]
    elif(type(info) == int):
        return [f"{parent}={info}"]
    elif(type(info) == str):
        return [f"{parent}='{info}'"]
    elif(type(info) == list):
        return to_cfg_list(info, parent)
    elif(type(info) == dict):
        return to_cfg_dict(info, parent)
    else:
        raise TypeError(f"Unable to handle {type(info)}")

print("\n".join(to_cfg(info)))

