#!/usr/bin/env python3

import os

print("""\
Content-Type: text/html

<!DOCTYPE html>
<html lang="en">
<pre>""")
for k, v in sorted(os.environ.items()):
    print(k, '=', repr(v))
print("""\
</pre>
</html>"""
)

