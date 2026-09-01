#!/usr/bin/env bash


DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null \
  | jq -r '.SPBluetoothDataType[0].device_connected[]
           | to_entries[]
           | select(.value.device_minorType == "Headphones")
           | .key')"

if [ -n "$DEVICES" ]; then
  sketchybar -m --set headphones icon=
else
  sketchybar -m --set headphones icon=""
fi



