#!/usr/bin/env python3
import os.path, sys
print(os.path.relpath(sys.argv[2], sys.argv[1]))
