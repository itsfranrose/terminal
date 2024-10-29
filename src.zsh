#!/usr/bin/zsh

thisdir="$(realpath "$(dirname "$0")")"

if [[ ! "$0" == *src.zsh ]]; then  # for lightdm's .xprofile
	if [ -d "$HOME"/.zim/modules/terminal ]; then
		thisdir="$HOME"/.zim/modules/terminal
	elif [ -d "$HOME"/Studio/Terminal ]; then
		thisdir="$HOME"/Studio/Terminal
	fi
fi

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
		find "${thisdir}" -type f -name "*.zwc" | xargs -I{} rm -v -f {}
		find "${thisdir}" -type d -name "*.zwc.d" | xargs -I{} rm -v -rf {}
		;;
	recompile)
		thisfile="${thisdir}/$(basename "$0")"
		source "${thisfile}" clean
		source "${thisfile}" compile
		;;
	dev)
		source "$thisdir"/src/eval-dev.zsh "$thisdir"/env env
		source "$thisdir"/src/eval-dev.zsh "$thisdir"/aliases zsh
		source "$thisdir"/src/eval-dev.zsh "$thisdir"/modules rc
		;;
esac

unset thisdir
