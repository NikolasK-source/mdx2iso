#!/usr/bin/bash

# MIT-License
#
# Copyright (C) 2023 Nikolas Koesling <nikolas@koesling.info>
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# dependencies: bash, iat (Iso9660 Analyzer Tool)

VERSION="1.0.0"

# check arguments
if [ $# -eq 0 ]
then
    echo "No arguments supplied"
    exit 64
fi

# --help, --version
for var in "$@"
do
    if [ "$var" = "--help" ]
    then
        me=`basename "$0"`
        echo "Convert mdx to iso"
        echo "  usage: $me [OPTIONS] input_file [output_file]"
        echo ""
        echo "  OPTIONS:"
        echo "    --help         print help and exit"
        echo "    --version      print version and exit"
        echo "    --version_iat  print Iso9660 Analyzer Tool version and exit"
        exit 0
    fi

    if [ "$var" = "--version" ]
    then
        echo "$VERSION"
        exit 0
    fi

    if [ "$var" = "--version_iat" ]
    then
        iat --version
        exit 0
    fi
done

if [ $# -gt 2 ]
then
    echo "Invalid arguments. Use --help for usage."
    exit 64
fi

INPUT=$1

if [ $# -eq 1 ]
then
    # create output file name from input file
    OUTPUT=$(basename "$1" ".mdx")
    OUTPUT="$OUTPUT.iso"
else
    # use supplied output file name
    OUTPUT=$2
fi

# check if file exists
if [ ! -n "$INPUT" ]
then
    echo "Input file does not exist."
    exit 66
fi

iat --iso -i "$INPUT" -o "$OUTPUT"
exit $?
