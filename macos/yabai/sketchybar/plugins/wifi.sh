#!/usr/bin/env sh

SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')"

if [ -n "$SSID" ]; then
  ICON="󰤨"
  LABEL="$SSID"
else
  ICON="󰤭"
  LABEL="N/A"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
