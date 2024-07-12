#!/usr/bin/zsh

() { 
	if [ $# -lt 1 ] || [ ! -d "$1" ]; then
		return 0
	fi
	
	rootd="$1"
	srcfiles="$(find "$rootd" \( -type d ! -name '*.d' ! -path "$rootd" -prune \) -o -type f -name '*.env' -print | sort)"
	eval "$(echo "$srcfiles" | xargs -I{} cat "{}")"
} "$@"
