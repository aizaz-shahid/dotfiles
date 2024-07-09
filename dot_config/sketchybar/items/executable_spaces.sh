#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" )

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    associated_space=$sid
    icon=${SPACE_ICONS[i]}
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    label.padding_right=20
    icon.highlight_color=0xffed8796
    label.font="sketchybar-app-font:Regular:16.0"
    label.background.height=26
    label.background.drawing=on
    label.background.color=0x903c3e4f
    label.background.corner_radius=8
    label.drawing=on
    script="$CONFIG_DIR/plugins/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid front_app_switched window_change
done

spaces=(
  background.color=0x903c3e4f
  background.border_color=0x90494d64
  background.border_width=2
  background.drawing=on
)

# separator=(
#   icon=􀆊
#   icon.font="$FONT:Heavy:16.0"
#   padding_left=15
#   padding_right=15
#   label.drawing=off
#   associated_display=active
#   # click_script='yabai -m space --create && sketchybar --trigger space_change'
#   icon.color=$WHITE
# )

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"       \
           # --add item separator left          \
           # --set separator "${separator[@]}"
