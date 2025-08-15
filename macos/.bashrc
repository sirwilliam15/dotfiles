#!/bin/bash

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

export PATH="/opt/homebrew/bin:$PATH"

alias grep="/opt/homebrew/bin/ggrep"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

source "$DOTFILES/rc_common.sh"