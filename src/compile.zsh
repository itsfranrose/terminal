#!/usr/bin/zsh

rootd="$1"
ftype="$2"

zdir="$rootd"/.zwc.d
mkdir -p "$zdir"

srcfiles="$(find "$rootd" -path "$rootd/.zwc.d" -prune -o \( -type d ! -name '*.d' ! -path "$rootd" -prune \) -o -type f -name "*.$ftype" -print)"
[ ! -n "$srcfiles" ] && exit 0

while IFS= read -r -d $'\n' file; do
	filename="$(echo "$file" | xargs -I{} realpath -s --relative-to="$rootd" {} | sed -E -e 's|/|--|g')"
	zfile="$zdir/$filename"
	zwcfile="$zfile".zwc

	[ -f "$zfile" ] && [ -f "$zwcfile" ] && [[ "$zwcfile" -nt "$file" ]] && continue

	echo "- compiling $filename"
	if [ ! -f "$zfile" ] || [[ "$file" -nt "$zfile" ]]; then
		cp "$file" "$zfile" 1>/dev/null
		[ $? -ne 0 ] && "(cp) error... didn't source $file" && break
	fi
	
	zcompile -UR "$zfile"
done < <(echo "$srcfiles")
