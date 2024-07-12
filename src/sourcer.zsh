#!/usr/bin/zsh

() { 
	if [ $# -lt 2 ] || [ ! -d "$1" ]; then
		return 0
	fi
	rootd="$1"
	ftype="$2"
	shift 2

	while [ $# -gt 0 ]; do
		case "$1" in
			-v|--verbose) verbose=true; shift;;
			-c|--compile) compile=true; shift;;
			*) break ;;
		esac
	done
	
	zdir="$rootd"/.zwc.d
	[ ! -d "$zdir" ] && mkdir -p "$zdir"

	if [ ! "$compile" = true ]; then
		eval "$(find "$zdir" -type f -name "*.$ftype" -print | sort | xargs -I{} cat {})"
		return 0
	fi
	
	# compiling
	srcfiles="$(find "$rootd" -path "$rootd/.zwc.d" -prune -o \( -type d ! -name '*.d' ! -path "$rootd" -prune \) -o -type f -name "*.$ftype" -print)"
	[ ! -n "$srcfiles" ] && return 0
	
	while IFS= read -r -d $'\n' file; do
		filename="$(echo "$file" | xargs -I{} realpath -s --relative-to="$rootd" {} | sed -E -e 's|/|--|g')"
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
	unset compile verbose
} "$@"

