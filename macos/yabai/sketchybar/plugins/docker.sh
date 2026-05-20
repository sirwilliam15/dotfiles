#!/usr/bin/env bash

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

if ! command -v docker >/dev/null 2>&1; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if ! docker info >/dev/null 2>&1; then
  sketchybar --set "$NAME" icon="󰡨" icon.color=0xff7a8478 label="Off"
  exit 0
fi

STATS="$(docker stats --no-stream --format '{{.MemUsage}}' 2>/dev/null)"

if [ -z "$STATS" ]; then
  sketchybar --set "$NAME" icon="󰡨" icon.color=0xff7a8478 label="0"
  exit 0
fi

COUNT="$(printf '%s\n' "$STATS" | wc -l | tr -d ' ')"

LABEL="$(printf '%s\n' "$STATS" | awk '{
  v = $1
  u = $1
  sub(/[A-Za-z]+$/, "", v)
  sub(/^[0-9.]+/,   "", u)
  if      (u == "KiB") v = v / 1024
  else if (u == "GiB") v = v * 1024
  else if (u == "TiB") v = v * 1024 * 1024
  else if (u == "B")   v = v / 1048576
  sum += v
} END {
  if (sum >= 1024) printf "%.1fG", sum / 1024
  else             printf "%.0fM", sum
}')"

sketchybar --set "$NAME" icon="󰡨" icon.color=0xff7fbbb3 label="$COUNT · $LABEL"
