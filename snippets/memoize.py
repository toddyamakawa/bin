#!/usr/bin/env python3
# USAGE: memoize.py
# DESCRIPTION: How to write memoize

from functools import wraps

def memoize(function):
    results = {}
    @wraps(function)
    def wrapper(*args):
        if args in results:
            return results[args]
        result = function(*args)
        results[args] = result
        return result
    return wrapper

@memoize
def fibonacci(n):
    if n < 2: return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print(fibonacci(25))

