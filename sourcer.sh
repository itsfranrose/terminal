#!/bin/bash

if [ -z "$1" ] && [ -d "$1" ]; then
    echo "$(tput setaf 2)arg 'dir' must be provided and must exist.$(tput sgr0)"
    exit 1
fi
directory="$1"

# source *.rc files in the current directory
files=($(find "$directory" -maxdepth 1 -name "*.rc" -type f))
for file in "${files[@]}"; do
    if [ -n "$file" ] && [ -f "$file" ]; then
        source "$file"
    fi
done

# recursively source any *.rc files in *.d directories
subdirs=($(find "$directory" -maxdepth 1 -name "*.d" ! -path "$directory" -type d))
for dir in "${subdirs[@]}"; do
    if [ -n "$dir" ] && [ -d "$dir" ]; then
        sourcer "$dir"
    fi
done
