#!/usr/bin/env sh

WIFI_IFACE="$(networksetup -listallhardwareports 2>/dev/null \
  | awk '/Hardware Port: Wi-Fi/{getline; print $2; exit}')"
[ -z "$WIFI_IFACE" ] && WIFI_IFACE="en0"

POWER="$(networksetup -getairportpower "$WIFI_IFACE" 2>/dev/null | awk '{print $NF}')"

if [ "$POWER" != "On" ]; then
  sketchybar --set "$NAME" icon="󰖪" label="Offline"
  exit 0
fi

if ! ifconfig "$WIFI_IFACE" 2>/dev/null | grep -q 'status: active'; then
  sketchybar --set "$NAME" icon="󰤫" label="Disconnected"
  exit 0
fi

sketchybar --set "$NAME" icon="󰤨" label="Connected"
