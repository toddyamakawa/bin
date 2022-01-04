#!/usr/bin/env python3
import argparse
import json
import sys
import xml.etree.cElementTree as etree

import pandas_read_xml as pdx

debug = False
#debug = True

def parse(parent, depth, path = ''):
    if depth == 0: return

    tag    = parent.tag
    attrib = parent.attrib
    text   = parent.text
    if text: text = text.rstrip()

    if debug:
        print(f'{path}.{tag}', attrib)
        if text: print(text)

    children = {}
    for a in attrib:
        children[f'@{a}'] = attrib[a]

    for child in parent:
        child_tag = child.tag
        child_info = parse(child, depth - 1, f'{path}.{tag}')

        # Handle duplicate tags
        if child_tag in children:
            if type(children[child_tag]) == list:
                # Append tag if it's already a list
                children[child_tag] += [child_info]
            else:
                # Create a new list
                children[child_tag] = [children[child_tag], child_info]
        else:
            children[child_tag] = child_info

    # Getting text this way isn't perfect
    # <greeting>Hello <name>Todd</name>. Welcome!</greeting>
    # Will result in "text" = "Hello " instead of "Hello . Welcome!"
    if text:
        if children:
            children['#text'] = text
        else:
            children = text

    return children


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input', nargs='?', type=argparse.FileType(), default=sys.stdin)
    args = parser.parse_args()

    # REVISIT: This works better
    df = pdx.read_xml(args.input)
    df = pdx.read_xml('AArch64-ccsidr_el1.xml')
    print(df.to_json())
    return 0

    # TODO: Get depth from argparse
    depth = -1

    # Parse input
    tree = etree.parse(args.input)
    root = tree.getroot()
    info = parse(root, depth)
    print(json.dumps(info, indent=2))

if __name__ == "__main__":
    sys.exit(main())

