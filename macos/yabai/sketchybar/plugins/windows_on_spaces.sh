#!/usr/bin/env bash

# Repaints the per-space app icons for every space in one pass.
#
# This replaces a fan-out where all 8 space items were subscribed to
# windows_on_spaces, so each trigger ran space.sh 8 times — and every one of
# those runs forked a shell, sourced the 36 KB icon_map.sh, and issued its own
# `yabai -m query --windows --space N`. Measured at ~246 ms per run, which at
# the observed event rate was ~6.4 CPU-seconds of shell work per wall second.
#
# Here it is one query, one jq pass, one icon_map source, one sketchybar call.
#
# Targets bash 3.2 (/bin/bash on macOS): no mapfile, no associative arrays.

command -v yabai      >/dev/null 2>&1 || exit 0
command -v jq         >/dev/null 2>&1 || exit 0
command -v sketchybar >/dev/null 2>&1 || exit 0

[ -r "$CONFIG_DIR/plugins/icon_map.sh" ] || exit 0
# shellcheck source=./icon_map.sh
source "$CONFIG_DIR/plugins/icon_map.sh"

# Must match the number of space items created in sketchybarrc.
MAX_SPACES=8

WINDOWS="$(yabai -m query --windows 2>/dev/null)" || exit 0
[ -z "$WINDOWS" ] && exit 0

# Pre-seed every slot so spaces that emptied get cleared rather than keeping a
# stale label.
ICONS=()
i=1
while [ "$i" -le "$MAX_SPACES" ]; do
  ICONS[$i]=""
  i=$((i + 1))
done

# unique_by dedupes app-per-space, so a browser with 12 windows contributes one
# glyph. It sorts as a side effect, matching the old `unique` ordering.
#
# Process substitution rather than a pipe: a piped while-loop runs in a subshell
# in bash 3.2 and the array writes would be discarded.
while IFS=$'\t' read -r sid app; do
  [ -z "$app" ] && continue
  [ "$sid" -ge 1 ] 2>/dev/null || continue
  [ "$sid" -le "$MAX_SPACES" ] || continue
  __icon_map "$app"
  ICONS[$sid]="${ICONS[$sid]}${icon_result}"
done < <(printf '%s' "$WINDOWS" | jq -r '
  [ .[]
    | select(."is-minimized" == false)
    | select(.app != "Finder")
    | {space: .space, app: .app} ]
  | unique_by([.space, .app])
  | .[]
  | "\(.space)\t\(.app)"')

# One invocation for all spaces instead of one per space.
ARGS=()
i=1
while [ "$i" -le "$MAX_SPACES" ]; do
  ARGS+=(--set "space.$i" "label=${ICONS[$i]}")
  i=$((i + 1))
done

sketchybar "${ARGS[@]}"
