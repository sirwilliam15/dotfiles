#!/usr/bin/env sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
LOWPOWER="$(pmset -g | awk '/lowpowermode/ {print $2}')"

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="󰁹" ;;
  [6-8][0-9])  ICON="󰂁" ;;
  [3-5][0-9])  ICON="󰁿" ;;
  [1-2][0-9])  ICON="󰁻" ;;
  *)           ICON="󰂃" ;;
esac

COLOR=0xffa7c080
if [ "$PERCENTAGE" -lt 20 ] && [ -z "$CHARGING" ]; then
  COLOR=0xffff5555
elif [ "$LOWPOWER" = "1" ]; then
  COLOR=0xffffcc00
fi

if [ -n "$CHARGING" ]; then
  ICON="󰂄"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" icon.color="$COLOR"
