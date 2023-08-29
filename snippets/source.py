#!/usr/bin/env python3
# USAGE: ./source.py <FILE>
# DESCRIPTION: Example for sourcing a file

import json
import os
import subprocess
import sys

sourcme = sys.argv[1]

command = f"source {sourcme} 1>&2 && env2json",
process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()
exitcode = process.returncode
if exitcode != 0:
    sys.exit(exitcode)
os.environ = json.loads(stdout.decode())

