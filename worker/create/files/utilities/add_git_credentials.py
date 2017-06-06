#!/usr/bin/python

import sys
import os.path

if not len(sys.argv) == 2:
	sys.exit(1)

credentials_file = os.path.expanduser('~') + '.git-credentials'
credentials = sys.argv[1]

with open(credentials_file, 'ab') as f:
    f.write(credentials + '\n')