#!/usr/bin/env sh

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffa7c080 \
    icon.color=0xff1e2326
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.color=0xffd3c6aa
fi
