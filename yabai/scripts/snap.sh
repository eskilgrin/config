#!/bin/bash
# Usage: snap.sh left|right|full
MIN_Y=40
SIDE="$1"

WIN=$(yabai -m query --windows --window)
DISPLAY_ID=$(echo "$WIN" | jq -r '.display')
FRAME=$(yabai -m query --displays --display "$DISPLAY_ID" | jq -r '.frame')

DX=$(echo "$FRAME" | jq -r '.x | floor')
DY=$(echo "$FRAME" | jq -r '.y | floor')
DW=$(echo "$FRAME" | jq -r '.w | floor')
DH=$(echo "$FRAME" | jq -r '.h | floor')

TOP=$DY
if [ "$TOP" -lt "$MIN_Y" ]; then
  TOP=$MIN_Y
fi

HEIGHT=$(( DH - (TOP - DY) ))

case "$SIDE" in
  right)
    WIDTH=$(( DW / 2 ))
    X=$(( DX + WIDTH ))
    ;;
  left)
    WIDTH=$(( DW / 2 ))
    X=$DX
    ;;
  full)
    WIDTH=$DW
    X=$DX
    ;;
  *)
    echo "usage: snap.sh left|right|full" >&2
    exit 1
    ;;
esac

yabai -m window --move abs:"$X":"$TOP"
yabai -m window --resize abs:"$WIDTH":"$HEIGHT"
