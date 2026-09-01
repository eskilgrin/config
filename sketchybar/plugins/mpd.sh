#!/usr/bin/env bash

# Check if Spotify is running at all — osascript will error/hang otherwise
running=$(osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"')

if [ "$running" != "true" ]; then
  icon=""
  output=""
else
  state=$(osascript -e 'tell application "Spotify" to player state as string')
  artist=$(osascript -e 'tell application "Spotify" to artist of current track as string')
  song=$(osascript -e 'tell application "Spotify" to name of current track as string')

  if [ "$state" = "playing" ]; then
    icon="󰝚"
  else
    icon="󰏤"
  fi

  output="${artist} • ${song}"
fi

sketchybar -m --set mpd icon="${icon}" \
              --set mpd label="${output}"
