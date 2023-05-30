#!/bin/bash

local mainrc_path=$1

# source *.rc files in the current directory
files=($(find "$mainrc_path" -maxdepth 1 -type f -name "*.rc"))
if [ ${#files[@]} -gt 0 ]; then # check if there are files
    for file in "${files[@]}"; do
        source "$file"
    done
fi

# recursively source any "mainrc" files in *.d directories
subdirs=($(find "$mainrc_path" -maxdepth 1 -type d -name "*.d" ! -path "$mainrc_path"))
if [ ${#subdirs[@]} -gt 0 ]; then # check if there are subdirectories
    for dir in "${subdirs[@]}"; do
        if [[ -d "$dir" ]]; then
            sourcer "$dir"
        fi
    done
fi
