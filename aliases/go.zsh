#!/usr/bin/zsh

alias gotest="gotestsum --hide-summary=output --format=dots"
alias gotestv="go test -v ./... | grep -E '^[[:space:]]*[^/]*_test\.go' -B 2 -A 3 --color=no"
