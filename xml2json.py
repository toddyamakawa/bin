#!/usr/bin/env python3
import argparse
import json
import sys
import xml.etree.cElementTree as etree

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
    if attrib: children['__attrib__'] = attrib
    if text: children['__text__'] = text.rstrip()

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

    return children


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input', nargs='?', type=argparse.FileType(), default=sys.stdin)
    args = parser.parse_args()

    # TODO: Get depth from argparse
    depth = -1

    # Parse input
    tree = etree.parse(args.input)
    root = tree.getroot()
    info = parse(root, depth)
    print(json.dumps(info, indent=2))

if __name__ == "__main__":
    sys.exit(main())

