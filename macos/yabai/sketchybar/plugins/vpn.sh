#!/usr/bin/env bash

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Detect VPN state from (in priority order):
#   1. Mullvad CLI       — authoritative when installed
#   2. scutil --nc list  — system-managed VPNs (WireGuard.app, IKEv2, etc.)
#   3. utun + RFC1918    — fallback for other third-party clients

STATE="off"
LABEL="VPN"

if command -v mullvad >/dev/null 2>&1; then
  MULLVAD_JSON="$(mullvad status --json 2>/dev/null)"
  case "$(printf '%s' "$MULLVAD_JSON" | jq -r '.state // empty')" in
    connected)
      STATE="on"
      LABEL="$(printf '%s' "$MULLVAD_JSON" \
        | jq -r '.details.location.hostname // "Mullvad"')"
      ;;
    connecting)    STATE="pending"; LABEL="..." ;;
    disconnecting) STATE="pending"; LABEL="..." ;;
  esac
fi

if [ "$STATE" = "off" ]; then
  NAMED="$(scutil --nc list 2>/dev/null | awk -F'"' '/\(Connected\)/ {print $2; exit}')"
  if [ -n "$NAMED" ]; then
    STATE="on"
    LABEL="$NAMED"
  fi
fi

if [ "$STATE" = "off" ]; then
  if ifconfig 2>/dev/null \
    | awk '/^utun[0-9]+:/ {iface=$1} /inet / && iface {print $2; iface=""}' \
    | grep -qE '^(10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.)'; then
    STATE="on"
    LABEL="VPN"
  fi
fi

case "$STATE" in
  on)      sketchybar --set "$NAME" icon="󰦝" icon.color=0xffa7c080 label="$LABEL" ;;
  pending) sketchybar --set "$NAME" icon="󰦝" icon.color=0xffdbbc7f label="$LABEL" ;;
  *)       sketchybar --set "$NAME" icon="󰦝" icon.color=0xff7a8478 label="Off" ;;
esac
