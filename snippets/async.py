#!/usr/bin/env python3
# USAGE: ./async.py
# DESCRIPTION: Asyncio example

import asyncio

async def print_numbers():
    for i in range(10):
        print(i)
        await asyncio.sleep(0.25)

async def fetch():
    fetched_text = 'fetched text'
    await asyncio.sleep(2)
    return fetched_text

async def main():
    task1 = asyncio.create_task(print_numbers())
    task2 = asyncio.create_task(fetch())
    fetched = await task2
    print(fetched)

asyncio.run(main())

