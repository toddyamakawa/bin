#!/usr/bin/env python3

import argparse
import sys

from rich.console import Console
from rich.table import Table

# TODO: Set from flag
header = True

# TODO: Add better argument parsing

parser = argparse.ArgumentParser()
parser.add_argument('input', nargs='?', type=argparse.FileType(), default=sys.stdin)
args = parser.parse_args()

table = Table(show_footer=False)
for line_number, line in enumerate(args.input):

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

