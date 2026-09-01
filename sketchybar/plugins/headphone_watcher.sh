#!/bin/bash

is_headphones_connected() {
  DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null \
    | jq -r '.SPBluetoothDataType[0].device_connected[]?
             | to_entries[]
             | select(.value.device_minorType == "Headphones")
             | .key')"
  [ -n "$DEVICES" ]
}

LAST_STATE=""
while true; do
  if is_headphones_connected; then
    STATE="connected"
  else
    STATE="disconnected"
  fi

  if [ "$STATE" != "$LAST_STATE" ]; then
    sketchybar --trigger headphone_change
    LAST_STATE="$STATE"
  fi

  sleep 2
done
