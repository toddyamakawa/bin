#!/usr/bin/env python3
# USAGE: ./threads.py
# DESCRIPTION: Example for running multiple threads

import subprocess
from concurrent.futures import ThreadPoolExecutor

def run_sleep():
    result = subprocess.run(['sleep', '1'])
    return result.returncode

num_parallel = 10
num_jobs = 100

exit_codes = []

with ThreadPoolExecutor(max_workers=num_parallel) as executor:
    futures = [executor.submit(run_sleep) for _ in range(num_jobs)]

    for future in futures:
        future.result()
        exit_codes.append(future.result())

print(exit_codes)

