is_headphones_connected() {
    OUTPUT="$(SwitchAudioSource -c -t output 2>/dev/null)"

    case "$OUTPUT" in
        *AirPods*|*Headphone*|*headphone*|*Bose*|*Sony*|*Beats*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
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
