#!/usr/bin/zsh

alias cpa="cp -av"
alias cpp="cp -rpv"
alias cpl="rsync -avh --no-links --no-devices --no-specials --partial --progress --info=progress2,stats --update --"
alias mvv="mv -v"

alias desktop-files="{ ls -d1 $HOME_DIR/.local/share/applications/* && ls -d1 /usr/share/applications/* }"

# diff
# https://stackoverflow.com/questions/4997693/given-two-directory-trees-how-can-i-find-out-which-files-differ-by-content
alias diffdir="diff --brief --recursive --new-file"

# ls
# todo: add assertion of existence of eza
# todo: double check eza options
alias ls="eza --group-directories-first"
alias la="ls -a"          # all files
alias ll="ls -l --git"    # long list
alias lla="ll -a"         # long list all files
alias lt="ll -t"          # long list and sort newest first
alias lrt="ll -rt"        # long list and sort oldest first
alias l1="ls -1"          # list on one column
alias la1="l1 -a"         # all files on one column
alias lR="ll -T"          # long list recursive as a tree
alias lx="ll -sextension" # long list sort by extension
alias lS="ll -ssize"      # long list sort asc fsize

alias grepfile="grep -R -n -H -C 5 --exclude-dir={.git}"
