#!/bin/sh
# Combined volume/headphone icon script

is_headphones_connected() {
  DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null \
    | jq -r '.SPBluetoothDataType[0].device_connected[]?
             | to_entries[]
             | select(.value.device_minorType == "Headphones")
             | .key')"
  [ -n "$DEVICES" ]
}

VOLUME=$(osascript -e 'output volume of (get volume settings)')
if is_headphones_connected; then
    ICON=""
else
    case "$VOLUME" in
        [6-9][0-9]|100) ICON="󰕾" ;;
        [3-5][0-9])     ICON="󰖀" ;;
        [1-9]|[1-2][0-9]) ICON="󰕿" ;;
        *)              ICON="󰖁" ;;
    esac
fi

sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
