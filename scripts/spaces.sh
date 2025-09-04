
#!/bin/bash

# Usage: ./spaces.sh [north|south|east|west|priority]
# Automatically detects screen resolution and uses appropriate yabai grid commands

_get_screen_resolution() {
  # Get the primary display resolution
  local resolution=$(system_profiler SPDisplaysDataType | grep Resolution | head -1 | awk '{print $2, $4}')
  echo "$resolution"
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
  
  # Get screen resolution and aspect ratio
  local resolution=$(_get_screen_resolution)
  local ratio=$(_get_aspect_ratio "$resolution")
  local is_widescreen=$(_is_widescreen "$ratio")
  
  # Choose grid command based on action and screen type
  case $action in
    "north")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Middle View (North) - from .skhdrc
        yabai -m window --grid 1:7:2:0:3:1
      else
        # Standard: 1st 2/3rds of the screen
        yabai -m window --grid 1:3:0:0:2:1
      fi
      ;;
    "south")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Bottom Left View (South) - from .skhdrc
        yabai -m window --grid 3:7:0:2:2:1
      else
        # Standard: Bottom left corner of screen
        yabai -m window --grid 2:2:0:1:1:1
      fi
      ;;
    "east")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: East - from .skhdrc
        yabai -m window --grid 1:7:5:0:2:1
      else
        # Standard: 2nd half of screen
        yabai -m window --grid 1:2:1:0:1:2
      fi
      ;;
    "west")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Top Left View (West) - from .skhdrc
        yabai -m window --grid 3:7:0:0:2:2
      else
        # Standard: 1st half of screen
        yabai -m window --grid 1:2:0:0:1:2
      fi
      ;;
    "priority")
      if [ "$is_widescreen" -eq 1 ]; then
        # Widescreen: Priority - from .skhdrc
        yabai -m window --grid 1:7:2:0:5:1
      else
        # Standard: 2nd 2/3rds of the screen
        yabai -m window --grid 1:3:1:0:2:1
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
  echo "Usage: $0 [north|south|east|west|priority]"
  echo "Automatically detects screen resolution and uses appropriate yabai grid commands"
  exit 1
fi

_put_window_in_space "$1"