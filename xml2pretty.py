#!/usr/bin/env python
import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument('input', nargs='?', type=argparse.FileType(), default=sys.stdin)
args = parser.parse_args()

#import xml.dom.minidom
#print(xml.dom.minidom.parse(args.input).toprettyxml())

import lxml.etree as etree
print(etree.tostring(etree.parse(args.input), pretty_print=True, encoding=str))

# REVISIT: There are some great Python 3.9+ options
# https://stackoverflow.com/questions/749796/pretty-printing-xml-in-python

