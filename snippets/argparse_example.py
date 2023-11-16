#!/usr/bin/env python3
# USAGE: ./argparse.py [OPTIONS]
# DESCRIPTION: Example for using argparse

import argparse

parser = argparse.ArgumentParser(description='Example script with command-line arguments')
parser.add_argument('-i', '--input', type=str, help='Input file path')
parser.add_argument('-o', '--output', type=str, help='Output file path')
parser.add_argument('--verbose', action='store_true', help='Enable verbose mode')
parser.add_argument('--debug', action='store_true', help='Enable debug mode')
args = parser.parse_args()

input_file = args.input
output_file = args.output
verbose = args.verbose
debug = args.debug

