#!/usr/bin/zsh

for file in $(find "$1" -type f -name "*.$2" -print | sort); do
    source "$file"
done
