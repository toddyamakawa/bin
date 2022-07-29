#!/usr/bin/env python3

# https://github.com/knosmos/cmdpxl/blob/main/cmdpxl/terminal_io.py
# https://stackoverflow.com/a/47548992

import sys, tty, termios

fd = sys.stdin.fileno()
old_settings = termios.tcgetattr(fd)

def getch():
	try:
		tty.setraw(sys.stdin.fileno())
		ch = sys.stdin.read(1)
	finally:
		termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

	# Deal with arrow keys
	#print(ch)
	if ch == '\x1b':
		for i in range(2):
			ch = sys.stdin.read(1)
			sys.stdin.flush()
		if ch == 'A':
			return "up"
		elif ch == 'B':
			return "down"
		elif ch == 'C':
			return "right"
		elif ch == 'D':
			return "left"
	return ch

while True:
	print(getch())

