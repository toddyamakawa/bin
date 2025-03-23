#!/usr/bin/env tt-python3
# vim: ft=python noet ts=4 sw=0 sts

from jira import JIRA

import os

def get_key():
	home = os.path.expanduser('~')
	jira_key_file = os.path.join(home, '.jira.apitoken')
	with open(jira_key_file, 'r') as f:
		return f.read().strip()

def get_url():
	home = os.path.expanduser('~')
	jira_url_file = os.path.join(home, '.jira.url')
	with open(jira_url_file, 'r') as f:
		return f.read().strip()

def get_client(email):
	api_token = get_key()
	url = get_url()
	return JIRA(server=url, basic_auth=(email, api_token))

