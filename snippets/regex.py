#!/usr/bin/env python3
# USAGE: Not made to run
# DESCRIPTION: Regex examples
# https://docs.python.org/3/howto/regex.html

p = re.compile(r'ab*', re.IGNORECASE)

p = re.compile('(a(b)c)d')
m = p.match('abcd')
m.group(0)
# 'abcd'
m.group(1)
# 'abc'
m.group(2)
# 'b'

p = re.compile(r'(?P<word>\b\w+\b)')
m = p.search( '(((( Lots of punctuation )))' )
m.group('word')
# 'Lots'
m.group(1)
# 'Lots'

