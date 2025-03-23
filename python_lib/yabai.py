#!/usr/bin/env tt-python3
# vim: ft=python noet ts=4 sw=0 sts

import json
import subprocess

def get_windows():
	cmd = ['yabai', '-m', 'query', '--windows']
	result = subprocess.run(cmd, capture_output=True)
	stdout = result.stdout.decode('utf-8')
	return json.loads(stdout)

