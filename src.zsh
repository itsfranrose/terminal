#!/usr/bin/zsh

thisdir="$(realpath "$(dirname "$0")")"

case "$1" in
	env)
		shift
		source "$thisdir"/src/eval.zsh "${thisdir}/env" env
		;;
	aliases)
		shift
		source "$thisdir"/src/eval.zsh "${thisdir}/aliases" zsh
		;;
	modules)
		shift
		source "$thisdir"/src/eval.zsh "${thisdir}/modules" rc
		;;
	compile)
		thisfile="${thisdir}/$(basename "$0")"
		compfile="$thisdir"/src/compile.zsh
		evalfile="$thisdir"/src/eval.zsh

		[[ ! "$thisfile".zwc -nt "$thisfile" ]] && zcompile -UR "$thisfile"                && echo "- compiling $thisfile"
		[[ ! "$compfile".zwc -nt "$compfile" ]] && zcompile -UR "$compfile"                && echo "- compiling $compfile"
		[[ ! "$evalfile".zwc -nt "$evalfile" ]] && zcompile -UR "$evalfile"                && echo "- compiling $evalfile"
		
		"$compfile" "$thisdir"/env env
		"$compfile" "$thisdir"/aliases zsh
		"$compfile" "$thisdir"/modules rc
		;;
	clean)
		thisfile="${thisdir}/$(basename "$0")"
		rm -v -rf \
			"$thisfile".zwc \
			"$thisdir"/src/compile.zsh.zwc \
			"$thisdir"/src/eval.zsh.zwc \
			"$thisdir"/env/.zwc.d \
			"$thisdir"/aliases/.zwc.d \
			"$thisdir"/modules/.zwc.d
		;;
	dev)
		source "$thisdir"/src/eval-dev.zsh "$thisdir"/env env
		source "$thisdir"/src/eval-dev.zsh "$thisdir"/aliases zsh
		source "$thisdir"/src/eval-dev.zsh "$thisdir"/modules rc
		;;
esac

unset thisdir
