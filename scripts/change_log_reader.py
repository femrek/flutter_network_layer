#!/usr/bin/env python3

import sys
import os

# get first argument as the file name
file = sys.argv[1]

# check if the file exists
if not os.path.isfile(file):
    sys.stderr.write("File not found!\n")
    sys.exit(1)

# get second argument as the version
version = sys.argv[2]

# check if the version is empty
if not version:
    sys.stderr.write("Version input not found!\n")
    sys.exit(1)

if version.startswith('core_v'):
    sys.stderr.write("Version input is outdated!\n")
    sys.exit(1)
elif version.startswith('dart_v'):
    sys.stderr.write("Version input is outdated!\n")
    sys.exit(1)
elif version.startswith('dio_v'):
    sys.stderr.write("Version input is outdated!\n")
    sys.exit(1)
elif version.startswith('v'):
    version = version[1:]
else:
    sys.stderr.write("Version input not valid!\n")
    sys.exit(1)

# get the change log
with open(file, 'r') as f:
    change_log = f.read()

# get the change log for the version
start = -1
end = -1
file_lines = change_log.split('\n')
for (i, line) in enumerate(file_lines):
    if start < 0:
        if version in line:
            start = i
    elif line.startswith('## '):
        end = i
        break

if start < 0:
    sys.stderr.write("Version not found in file!\n")
    sys.exit(1)

if end < 0:
    end = len(file_lines)

version_change_log = '\n'.join(file_lines[start + 1:end])

# remove the empty lines
version_change_log = version_change_log.strip()

# check if the version change log is empty
if not version_change_log:
    sys.stderr.write("Version not found in lines!\n")
    sys.exit(1)

# print the version change log
print(version_change_log)
