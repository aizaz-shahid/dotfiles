#!/bin/bash

update() {
  WIDTH="dynamic"
  if [ "$SELECTED" = "true" ]; then
    WIDTH="0"
  fi

  space_index=${NAME##*.}
  apps=$(yabai -m query --windows --space $space_index | jq -r '.[].app' | sort -u)

  icon_strip=""
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      icon=$($CONFIG_DIR/plugins/icon_map.sh "$app")
      if [ -n "$icon" ]; then
        icon_strip+="$icon "
      fi
    done <<< "$apps"
    icon_strip=${icon_strip% } # Remove trailing space
  else
    icon_strip="🫗"
  fi

  # echo "Sender: $SENDER Space: $space_index Icon strip: $icon_strip"

  sketchybar --set $NAME label="$icon_strip"
  sketchybar --animate tanh 10 --set $NAME icon.highlight=$SELECTED # label.width="dynamic" icon.width="dynamic"
}

case "$SENDER" in
  "space_change"|"front_app_switched") update ;;
  *) ;;
esac
