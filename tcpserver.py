#!/usr/bin/env python3

import argparse
import asyncio

parser = argparse.ArgumentParser(description='TCP Server')
parser.add_argument('--port', type=int, default=9888, help='TCP port')
args = parser.parse_args()
port = args.port

async def handle_echo(reader, writer):
    data = await reader.read(100)
    message = data.decode()
    addr = writer.get_extra_info('peername')
    print(f'[{addr}] Received: {message}')
    print(f'[{addr}] Send    : {message}')
    writer.write(data)
    await writer.drain()
    print(f'[{addr}] Close')
    writer.close()
    await writer.wait_closed()

async def main():
    server = await asyncio.start_server(handle_echo, '127.0.0.1', port)
    addrs = ', '.join(str(sock.getsockname()) for sock in server.sockets)
    print(f'Serving on {addrs}')
    async with server:
        await server.serve_forever()

asyncio.run(main())

