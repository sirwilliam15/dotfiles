#!/bin/bash

# Loops through every window on the current space and assigns each one to a
# grid slot (via spaces.sh) based on the application type.
#
# Rules:
#   browsers (firefox, librewolf, ...)      -> north
#   code editors (vscode, cursor, ...)      -> priority
#   terminals (ghostty, iterm, ...)         -> south
#   chat apps (signal, telegram, ...)       -> west
#   mail / calendar apps                    -> east
#   everything else                         -> north (default)
#
# Usage: ./organize-windows.sh [--all]
#   (default)  only windows on the currently focused space
#   --all      every window across all spaces/displays

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
SPACES="$DOTFILES/scripts/spaces.sh"

# Map an application name to a grid direction understood by spaces.sh.
# Matching is case-insensitive substring matching.
_direction_for_app() {
  local lc
  lc=$(echo "$1" | tr '[:upper:]' '[:lower:]')

  case "$lc" in
    *firefox*|*librewolf*|*waterfox*|*chrome*|*chromium*|*safari*|*brave*|*edge*|*vivaldi*|*opera*|*arc*|*zen*|*duckduckgo*|*tor\ browser*)
      echo "north" ;;
    *vscodium*|*vscode*|*"visual studio code"*|*cursor*|*"sublime text"*|*zed*|*neovim*|*nvim*|*emacs*|*xcode*|*intellij*|*pycharm*|*webstorm*|*goland*|*clion*|*rider*|*"android studio"*)
      echo "priority" ;;
    *ghostty*|*terminal*|*iterm*|*alacritty*|*kitty*|*wezterm*|*warp*|*tabby*|*hyper*)
      echo "south" ;;
    *signal*|*telegram*|*slack*|*discord*|*whatsapp*|*messages*|*element*|*zulip*|*matrix*|*"microsoft teams"*)
      echo "west" ;;
    *mail*|*calendar*|*outlook*|*fantastical*|*spark*|*thunderbird*|*proton\ calendar*)
      echo "east" ;;
    *)
      echo "north" ;;
  esac
}

# Decide which windows to query.
query_args=(--windows --space)
if [ "$1" = "--all" ]; then
  query_args=(--windows)
fi

# Skip minimized/hidden windows; feed "id<TAB>app" pairs to the loop.
while IFS=$'\t' read -r id app; do
  [ -z "$id" ] && continue
  dir=$(_direction_for_app "$app")
  "$SPACES" "$dir" "$id"
done < <(yabai -m query "${query_args[@]}" \
  | jq -r '.[] | select(."is-minimized" == false and ."is-hidden" == false) | "\(.id)\t\(.app)"')
