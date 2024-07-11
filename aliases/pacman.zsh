#!/usr/bin/zsh

alias -g pac=pacman

alias -g pac-s='pac -Sy'
alias -g pac-fs='pac -Syy'

alias -g pac-u='pac -Syu'
alias -g pac-f='pac -Syyu'

alias -g pac-i='pac -S --needed'
alias -g pac-il='pac -U'

alias -g pac-r='pac -Rs'
alias -g pac-rn='pac -R'
alias -g pac-rp='pac -Rns'  # purge: also remove config files

alias -g pac-s='pac -Ss'
alias -g pac-sl='pac -Qs'

alias -g pac-ls='pac -Si'
alias -g pac-lsl='pac -Qil'

alias -g pac-orphans="pac -Qdt"

alias -g pacown-ls="pac -Ql"
alias -g pacown-lsdb="pac -Fl"
alias -g pacown-s="pac -Qo"
alias -g pacown-sdb="pac -Fo"
