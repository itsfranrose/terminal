#!/usr/bin/zsh

while IFS=$'\n' read -r -d $'\n' file; do
	source "$file"
done < <(find "$1" -type f -name "*.$2" -print | sort)
