#!/bin/bash

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[[ ":$PATH:" != *":/opt/homebrew/bin:"* ]] && export PATH="/opt/homebrew/bin:$PATH"

alias grep="/opt/homebrew/bin/ggrep"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias duh='du -h -d 1'

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
source "$DOTFILES/rc_common.sh"