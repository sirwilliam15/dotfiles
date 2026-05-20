#!/usr/bin/env sh

if [ "$SENDER" = "mouse.clicked" ]; then
  osascript -e 'tell application "System Events" to tell process "ControlCenter" to click (first menu bar item of menu bar 1 whose description is "Clock")' >/dev/null 2>&1
  exit 0
fi

sketchybar --set "$NAME" label="$(date '+%a %b %d %H:%M')"
