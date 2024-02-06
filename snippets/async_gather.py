#!/usr/bin/env python3
# USAGE: ./async.py
# DESCRIPTION: Asyncio example

import asyncio
from time import sleep

async def job(i):
    #sleep(1)
    await asyncio.sleep(1)
    print(i)

async def main():
    tasks = []
    for i in range(10):
        task = asyncio.create_task(job(i))
        tasks.append(task)
    await asyncio.gather(*tasks)

asyncio.run(main())

