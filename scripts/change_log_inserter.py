#!/usr/bin/env python3

import sys
import os
import re
import tempfile
import shutil

# Validate command line arguments
if len(sys.argv) != 4:
    sys.stderr.write("Usage: python script.py <input_file> <version_code> <target_file>\n")
    sys.exit(1)

input_file = sys.argv[1]
version_code = sys.argv[2]
target_file = sys.argv[3]

# Validate version_code: only allow alphanumeric, dots, dashes (e.g., "v1.0.0-beta")
if not re.match(r'^v\d+\.\d+\.\d+$', version_code):
    sys.stderr.write("Invalid version code format. Use only letters, numbers, dots, or dashes.\n")
    sys.exit(1)

# Check if the input file exists
if not os.path.isfile(input_file):
    sys.stderr.write("Input file not found!\n")
    sys.exit(1)

# Check if the target file exists
if not os.path.isfile(target_file):
    sys.stderr.write("Target file not found!\n")
    sys.exit(1)

# Read the input file
with open(input_file, 'r') as f:
    input_content = f.read().strip()

# Prepare the content to prepend
prepend_content = f"## {version_code[1:]}\n\n{input_content}\n\n"

# Create a temporary file
with tempfile.NamedTemporaryFile('w', delete=False) as tmp_file:
  # Write the version and input content at the top
  tmp_file.write(prepend_content)

  # Copy the rest of the original file line by line
  with open(target_file, 'r') as original:
    shutil.copyfileobj(original, tmp_file)

# Replace the original file with the temp file
shutil.move(tmp_file.name, target_file)


print(f"Prepended version code and input to {target_file}.")
