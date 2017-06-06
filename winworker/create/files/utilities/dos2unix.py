#!/usr/bin/python

import sys

windows_line_ending = '\r\n'
linux_line_ending = '\n'

if not len(sys.argv) == 2:
	sys.exit(1)

filename = sys.argv[1]

with open(filename, 'rb') as f:
    content = f.read()
    content = content.replace(windows_line_ending, linux_line_ending)

with open(filename, 'wb') as f:
    f.write(content)