#!/bin/bash

if [ "$1" = "$WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0x44ffffff label.color=0xffffffff
else
  sketchybar --set $NAME background.color=0x22ffffff label.color=0xffaaaaaa
fi
