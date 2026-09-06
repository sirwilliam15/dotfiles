#!/usr/bin/env sh

# On front_app_switched sketchybar passes the app name in $INFO. A plain
# `sketchybar --update` (what wake.sh does) sets no $INFO, so without a fallback
# the label keeps showing whatever app was frontmost before the machine slept.

if [ "$SENDER" = "front_app_switched" ] && [ -n "$INFO" ]; then
  sketchybar --set "$NAME" label="$INFO"
  exit 0
fi

if command -v yabai >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  APP="$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')"
  [ -n "$APP" ] && sketchybar --set "$NAME" label="$APP"
fi
