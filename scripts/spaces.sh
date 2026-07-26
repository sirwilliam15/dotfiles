
#!/bin/bash

# Usage: ./spaces.sh [north|south|east|west|priority]
# Automatically detects screen resolution and uses appropriate yabai grid commands

_get_screen_resolution() {
  # Get the resolution of the display holding the target window.
  # Pass a window id to target a specific window; omit for the focused window.
  local window_id=$1
  local display_id

  if [ -n "$window_id" ]; then
    # Look the window up in the full list; the "--window <id>" selector is
    # unreliable across yabai versions.
    display_id=$(yabai -m query --windows 2>/dev/null \
      | jq -r --arg id "$window_id" '.[] | select(.id == ($id|tonumber)) | .display') || return 1
  else
    display_id=$(yabai -m query --windows --window 2>/dev/null | jq -r '.display') || return 1
  fi

  yabai -m query --displays \
    | jq -r --argjson id "$display_id" \
      '.[] | select(.index == $id) | "\(.frame.w|floor) \(.frame.h|floor)"'
}

_get_aspect_ratio() {
  local resolution=$1
  local width=$(echo $resolution | awk '{print $1}')
  local height=$(echo $resolution | awk '{print $2}')
  
  # Calculate aspect ratio
  local ratio=$(echo "scale=3; $width / $height" | bc -l)
  echo "$ratio"
}

_is_widescreen() {
  local ratio=$1
  # 21:9 ≈ 2.33, 16:9 ≈ 1.78, 16:10 ≈ 1.6
  # Consider widescreen if ratio > 2.0 (closer to 21:9)
  local is_wide=$(echo "$ratio > 2.0" | bc -l)
  echo "$is_wide"
}

_put_window_in_space() {
  local action=$1
  # Optional target window id; empty means operate on the focused window.
  local win=$2

  # Get screen resolution and aspect ratio (for the target window's display)
  local resolution=$(_get_screen_resolution "$win")
  local ratio=$(_get_aspect_ratio "$resolution")
  local is_widescreen=$(_is_widescreen "$ratio")
  
  # Choose grid command based on action and screen type
  case $action in
    "north")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Middle View (North) - from .skhdrc
        yabai -m window ${win} --grid 1:7:2:0:3:1
      else
        # Standard: 1st 2/3rds of the screen
        yabai -m window ${win} --grid 1:3:0:0:2:1
      fi
      ;;
    "south")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Bottom Left View (South) - from .skhdrc
        yabai -m window ${win} --grid 3:7:0:2:2:1
      else
        # Standard: Bottom left corner of screen
        yabai -m window ${win} --grid 2:2:0:1:1:1
      fi
      ;;
    "east")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: East - from .skhdrc
        yabai -m window ${win} --grid 1:7:5:0:2:1
      else
        # Standard: 2nd half of screen
        yabai -m window ${win} --grid 1:2:1:0:1:2
      fi
      ;;
    "northwest")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Top Left View (Northwest) - from .skhdrc
        yabai -m window ${win} --grid 3:7:0:0:2:2
      else
        # Standard: Top left corner of screen
        yabai -m window ${win} --grid 2:2:0:0:1:1
      fi
      ;;
    "west")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Top Left View (West) - from .skhdrc
        yabai -m window ${win} --grid 3:7:0:0:2:2
      else
        # Standard: 1st half of screen
        yabai -m window ${win} --grid 1:2:0:0:1:2
      fi
      ;;
    "priority")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Priority - from .skhdrc
        yabai -m window ${win} --grid 1:7:2:0:5:1
      else
        # Standard: 2nd 2/3rds of the screen
        yabai -m window ${win} --grid 1:3:1:0:2:1
      fi
      ;;
    *)
      echo "Usage: $0 [north|south|east|west|priority]"
      echo "Automatically detects screen resolution and uses appropriate yabai grid commands"
      exit 1
      ;;
  esac
}

# Main execution
if [ $# -eq 0 ]; then
  echo "Usage: $0 [north|south|east|west|northwest|priority] [window_id]"
  echo "Automatically detects screen resolution and uses appropriate yabai grid commands"
  echo "Omit window_id to position the currently focused window."
  exit 1
fi

_put_window_in_space "$1" "$2"