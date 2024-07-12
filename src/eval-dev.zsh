#!/usr/bin/zsh

eval "$(find "$1" -path "$1"/.zwc.d -prune -o \( -type d ! -name "*.d" ! -path "$1" -prune \) -o -type f -name "*.$2" -print | sort | xargs -I{} cat {})"
