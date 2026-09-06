#!/bin/bash

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[[ ":$PATH:" != *":/opt/homebrew/bin:"* ]] && export PATH="/opt/homebrew/bin:$PATH"

alias grep="/opt/homebrew/bin/ggrep --color=auto"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias duh='du -h -d 1'

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
source "$DOTFILES/rc_common.sh"

# yabai restart nag — defines yabai_uptime_days / yabai_uptime_check
if [[ -r "$DOTFILES/macos/yabai/yabai-uptime.sh" ]]; then
    source "$DOTFILES/macos/yabai/yabai-uptime.sh"
    # Interactive shells only, so it never contaminates script or scp output.
    # _YABAI_NAG_SHOWN keeps the banner to once per shell even if this rc gets
    # sourced more than once; calling yabai_uptime_check by hand still works.
    if [[ $- == *i* && -z "$_YABAI_NAG_SHOWN" ]]; then
        _YABAI_NAG_SHOWN=1
        yabai_uptime_check
    fi
fi
