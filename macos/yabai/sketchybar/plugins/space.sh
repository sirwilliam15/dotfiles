#!/usr/bin/env bash

# shellcheck source=./icon_map.sh
source "$CONFIG_DIR/plugins/icon_map.sh"

SID="${NAME#space.}"

ICONS=""
if command -v yabai >/dev/null 2>&1; then
  ICONS="$(yabai -m query --windows --space "$SID" 2>/dev/null \
    | jq -r '[.[] | select(."is-minimized"==false) | .app] | unique | .[]' \
    | while IFS= read -r app; do
        [ -z "$app" ] && continue
        __icon_map "$app"
        printf '%s' "$icon_result"
      done)"
fi

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffa7c080 \
    icon.color=0xff1e2326 \
    label.color=0xff1e2326 \
    label.drawing=on \
    label="$ICONS"
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.color=0xffd3c6aa \
    label.color=0xffd3c6aa \
    label.drawing=on \
    label="$ICONS"
fi
