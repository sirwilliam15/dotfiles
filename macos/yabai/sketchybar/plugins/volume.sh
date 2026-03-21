#!/usr/bin/env sh

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$(osascript -e 'output volume of (get volume settings)')"

  case "$VOLUME" in
    [7-9][0-9]|100) ICON="󰕾" ;;
    [3-6][0-9])     ICON="󰖀" ;;
    [1-2][0-9])     ICON="󰕿" ;;
    *)              ICON="󰝟" ;;
  esac

  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
fi
