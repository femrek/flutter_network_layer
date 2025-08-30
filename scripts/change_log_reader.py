#!/usr/bin/env python3

import sys
import os

# get first argument as the file name
if len(sys.argv) < 3:
    sys.stderr.write("Usage: script.py <file> <version>\n")
    sys.exit(1)

file = sys.argv[1]
version = sys.argv[2]

# check if the file exists
if not os.path.isfile(file):
    sys.stderr.write("File not found!\n")
    sys.exit(1)

# check if the version is empty
if not version:
    sys.stderr.write("Version input not found!\n")
    sys.exit(1)

# handle version formats
if version.startswith(("core_v", "dart_v", "dio_v")):
    sys.stderr.write("Version input is outdated!\n")
    sys.exit(1)
elif version.startswith("v"):
    version = version[1:]
else:
    sys.stderr.write("Version input not valid!\n")
    sys.exit(1)

# read the file
with open(file, "r", encoding="utf-8") as f:
    change_log = f.read()

# locate the version changelog
file_lines = change_log.splitlines()
start, end = -1, -1

for i, line in enumerate(file_lines):
    if start < 0 and f"{version} -" in line:
        start = i
    elif start >= 0 and line.startswith("## "):
        end = i
        break

if start < 0:
    sys.stderr.write("Version not found in file!\n")
    sys.exit(1)

if end < 0:
    end = len(file_lines)

version_change_log = "\n".join(file_lines[start + 1:end]).strip()

if not version_change_log:
    sys.stderr.write("Version not found in lines!\n")
    sys.exit(1)

# print the version change log
print(version_change_log)
