#!/usr/bin/env python3

from rich.console import Console
from rich.table import Table
from sys import argv

# TODO: Set from flag
header = True

# TODO: Add better argument parsing
csv_file = argv[1]

table = Table(show_footer=False)

log_lines = open(csv_file, 'r').readlines()
for line_number, line in enumerate(log_lines):

    # Parse line
    line = line.strip()
    if not line: continue
    row = line.split(',')

    # Add header
    if header:
        for cell in row:
            table.add_column(cell)
        header = False

    # Add row
    else:
        table.add_row(*row)

# Print
console = Console()
console.print(table)

