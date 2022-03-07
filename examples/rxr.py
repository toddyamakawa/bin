#!/usr/bin/env python
# https://github.com/0xdanelia/rxr

# MIT License
#
# Copyright (c) 2022 0xdanelia
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

### Regular Expression Replacer ###
import sys, re

# read input, produce output
def process():
    # grab command line arguments
    args = sys.argv
    # check if there are enough args (args[0] is just the name of the script)
    if len(args) == 1:
        err_end()
    elif len(args) == 2:
        # see if the user was trying to display the help text
        if args[1] == '--help':
            help()
        else:
            err_not_enough_args()

    # grab the regex and replacement strings (last two args)
    regex = args[-2]
    replacement = args[-1]
    # process any optional arguments
    option_count = 0
    option_print = False
    option_flags = re.MULTILINE
    for arg in args[1:-2]:
        # handle long-form flags
        if arg.startswith('--'):
            if arg.startswith('--count='):
                try:
                    option_count = int(arg[8:])
                except Exception as exc:
                    err_count_NAN()
                if option_count < 0:
                    option_count = 0
            elif arg == '--ignore-case':
                option_flags = option_flags | re.IGNORECASE
            elif arg == '--ascii-only':
                option_flags = option_flags | re.ASCII
            elif arg == '--dot-all':
                option_flags = option_flags | re.DOTALL
            elif arg == '--print':
                option_print = True
            elif arg == '--help':
                help()
            else:
                err_unknown_option(arg)
        # handle single character flags
        elif arg.startswith('-'):
            for a in arg[1:]:
                if a == 'i':
                    option_flags = option_flags | re.IGNORECASE
                elif a == 'a':
                    option_flags = option_flags | re.ASCII
                elif a == 'd':
                    option_flags = option_flags | re.DOTALL
                elif a == 'p':
                    option_print = True
                else:
                    err_unknown_option('-' + a)
        else:
            err_unknown_option(arg)

    # process input from stdin
    rnum = 0
    if not sys.stdin.isatty():
        lines = ''.join(item for item in sys.stdin.readlines())
        try:
            rlines, rnum = re.subn(regex, replacement, lines, option_count, option_flags)
            print(rlines, end='')
        except Exception as exc:
            err_during_replace(exc)

    if option_print:
        eprint('Performed ' + str(rnum) + ' replacement(s)')
    
    sys.exit(0)

# how to call rxr
def print_usage():
    print('Usage: rxr [OPTION...] EXPRESSION REPLACEMENT')

# everything you need to know is right here
def help():
    print_usage()    
    print('Perform a regular expression find/replace on stdin using Python\'s re engine.')
    print()
    print('rxr does nothing if stdin is not provided.')
    print('It is recommended to surround your arguments in \'single quotes\' to preserve')
    print('their formatting as your shell passes them into rxr. If you want your')
    print('arguments to have any single quote literals, escape them with \\\'')
    print()
    print('  -i, --ignore-case     treat uppercase and lowercase letters as the same')
    print('  -a, --ascii-only      perform ascii-only matching instead of unicode')
    print('  -d, --dot-all         the dot will match on everything, including newlines')
    print('  -p, --print           print the number of replacements made')
    print('      --count=NUM       if NUM > 0, limit the number of replacements to NUM')
    print('      --help            display this help text and exit')
    print()
    print('For more information about optional flags or regular expression syntax, visit')
    print('https://docs.python.org/3/library/re.html#re.sub')
    print()
    print('Example:')
    print(' $ echo "hello_foobar_world" | rxr \'_[a-z]*_\' \'@\'')
    print('-> hello@world')
    print()
    sys.exit(0)

# print to stderr to avoid piping these messages into some other program
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# end any error messages with some useful advice, then exit with an error code
def err_end():
    print_usage()
    eprint('rxr --help for more info')
    sys.exit(1)

def err_not_enough_args():
    eprint('rxr: not enough arguments')
    err_end()

def err_count_NAN():
    eprint('rxr: --count=NUM option must be a number')
    err_end()

def err_unknown_option(option):
    eprint('rxr: ' + option + ' is not a recognized option')
    err_end()

def err_during_replace(exc):
    eprint('rxr: regex syntax error')
    eprint(exc)
    err_end()

# script starts here
process()

