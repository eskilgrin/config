#!/bin/bash
MIN_Y=40
WINDOW_ID="$1"

WIN=$(yabai -m query --windows --window "$WINDOW_ID") || exit 0

X=$(echo "$WIN" | jq -r '.frame.x | floor')
Y=$(echo "$WIN" | jq -r '.frame.y | floor')

if [ "$Y" -lt "$MIN_Y" ]; then
  yabai -m window "$WINDOW_ID" --move abs:"$X":"$MIN_Y"
fi
