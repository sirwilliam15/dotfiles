#!/bin/bash

source "$HOME/.dotfiles/rc_common.sh"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

export PATH="/opt/homebrew/bin:$PATH"

alias grep="/opt/homebrew/bin/ggrep"
