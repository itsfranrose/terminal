#!/usr/bin/zsh

_terminal_src_arg_zero="$0"

() {
	thisdir="$(realpath "$(dirname "$_terminal_src_arg_zero")")"
	thisfile="${thisdir}/$(basename "$_terminal_src_arg_zero")"

	# compile this file
	if [ ! -f "$thisfile".zwc ] || [[ ! "$thisfile".zwc -nt "$thisfile" ]]; then
		zcompile -UR "$thisfile"
		source "$thisfile"
		unset _terminal_src_arg_zero
		return 2>/dev/null
		exit
	fi
	
	# source "$thisdir"/src.zsh env
	source "$thisdir"/src.zsh aliases $@
	source "$thisdir"/src.zsh modules $@
} "$@"

unset _terminal_src_arg_zero
