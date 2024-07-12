#!/usr/bin/zsh

() { 
	if [ $# -lt 1 ] || [ ! -d "$1" ]; then
		return 0
	fi
	if [ $# -ge 2 -a "$2" = -v ]; then
		verbose=true
	fi

	rootd="$1"
	srcfiles="$(find "$rootd" -path "$rootd/.zwc.d" -prune -o \( -type d ! -name '*.d' ! -path "$rootd" -prune \) -o -type f -name '*.zsh' -print | sort)"
	[ ! -n "$srcfiles" ] && return 0
	
	zdir="$rootd"/.zwc.d
	[ ! -d "$zdir" ] && mkdir -p "$zdir"
	
	while IFS= read -r -d $'\n' file; do
		filename="$(basename "$file")"
		zfile="$zdir/$filename"
		zwcfile="$zfile".zwc

		if [ -f "$zfile" ] && [ -f "$zwcfile" ] && [[ "$zwcfile" -nt "$file" ]]; then
			source "$zfile" && continue
		fi

		[ "$verbose" = true ] && echo "- compiling $filename"
		
		if [ ! -f "$zfile" ] || [[ "$file" -nt "$zfile" ]]; then
			cp "$file" "$zfile" 1>/dev/null
			[ $? -ne 0 ] && "(cp) error... didn't source $file" && break
		fi
		
		zcompile -UR "$zfile"
		source "$zfile"
	done < <(echo "$srcfiles")
} "$@"

