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
	
	case "$1" in
		env)
			shift
			source "$thisdir"/src/env.zsh "${thisdir}/env" "$@"
			;;
		aliases)
			shift
			source "$thisdir"/src/sourcer.zsh "${thisdir}/aliases" zsh $@
			;;
		modules)
			shift
			source "$thisdir"/src/sourcer.zsh "${thisdir}/modules" rc $@
			;;
	esac
} "$@"

unset _terminal_src_arg_zero
