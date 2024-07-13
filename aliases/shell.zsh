#!/usr/bin/zsh

# TODO: add aliases for file/dir/disk space usage
alias xclip-board="xclip -selection clipboard"
alias grep='grep --color=auto'
alias -g man="$HOME/.local/bin/batman-s --wrap=never --paging=always"

alias ipy="python3 -c 'import IPython;
IPython.terminal.ipapp.launch_new_instance()'"

#
# sourcers
#

alias srcsh='source "$TERMINAL_DIR"/src.zsh dev'
alias srczsh='source "$HOME"/.zshrc'
alias srcbash='source "$HOME"/.bashrc'
