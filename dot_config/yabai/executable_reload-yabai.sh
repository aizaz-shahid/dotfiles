#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reload Yabai
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName yabai --signal reload 

# Documentation:
# @raycast.author aizazshahid
# @raycast.authorURL https://raycast.com/aizazshahid

yabai --signal reload

echo "Yabai Reloaded"

