#!/usr/bin/env python3
# USAGE: gitlab-show-mr
# DESCRIPTION: TODO

import json
import os
import requests
import sys

def get_key():
    home = os.path.expanduser("~")
    gitlab_key_file = os.path.join(home, '.gitlab_key')
    with open(gitlab_key_file, 'r') as f:
        return f.read().strip()

def get_url():
    home = os.path.expanduser("~")
    gitlab_url_file = os.path.join(home, '.gitlab_url')
    with open(gitlab_url_file, 'r') as f:
        return f.read().strip()

def get_project(gitlab_url, private_token, project_name):
    headers = {'PRIVATE-TOKEN': private_token}
    params = {
        'search': os.path.basename(project_name),
        'per_page': 100
    }
    response = requests.get(f'{gitlab_url}/api/v4/projects', headers=headers, params=params)

    for project in response.json():
        if project['path_with_namespace'] == project_name:
            return project
            project_id = project['id']
            break

    return None

def get_mr(gitlab_url, private_token, project_id, mr_iid):
    headers = {'PRIVATE-TOKEN': private_token}
    url = f'{gitlab_url}/api/v4/projects/{project_id}/merge_requests/{mr_iid}'
    response = requests.get(url, headers=headers)
    return response.json()

