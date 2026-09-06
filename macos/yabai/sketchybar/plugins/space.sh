#!/usr/bin/env sh

# Selection highlight only — runs on space_change, which is user-initiated and
# rare. The app icons in the label are owned by windows_on_spaces.sh, which
# repaints every space in a single batch. Keeping the two concerns apart is what
# lets this script skip the yabai query and the 36 KB icon_map source it used to
# do on every window event.
#
# Colours and label text are independent sketchybar properties, so the two
# scripts never clobber each other.

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffa7c080 \
    icon.color=0xff1e2326 \
    label.color=0xff1e2326 \
    label.drawing=on
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.color=0xffd3c6aa \
    label.color=0xffd3c6aa \
    label.drawing=on
fi
