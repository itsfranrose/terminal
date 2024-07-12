#!/usr/bin/zsh

eval "$(find "$1" -type f -name "*.$2" -print | sort | xargs -I{} cat {})"
