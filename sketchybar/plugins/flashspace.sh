#!/bin/bash
# $1 = workspace name this item represents (passed from sketchybarrc)
# $WORKSPACE = env var set by the flashspace_workspace_change event

if [ "$1" = "$WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.color=0xff89b4fa \
    label.color=0xff1e1e2e
else
  sketchybar --set "$NAME" \
    background.color=0x22ffffff \
    label.color=0xffaaaaaa
fi
