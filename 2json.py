#!/usr/bin/env python
import json, yaml
import argparse, sys
parser = argparse.ArgumentParser()
parser.add_argument('input', nargs='?', type=argparse.FileType(), default=sys.stdin)
args = parser.parse_args()

data = yaml.safe_load(args.input)
print(json.dumps(data, indent=2))

