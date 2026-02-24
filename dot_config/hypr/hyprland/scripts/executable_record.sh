#!/bin/bash

AUDIO_SOURCE="97.monitor"

if pgrep -x "wl-screenrec" >/dev/null; then
  pkill -SIGINT wl-screenrec
  notify-send "Recording stopped"
else
  geometry=$(slurp)
  if [ -n "$geometry" ]; then
    dateTime=$(date +%m-%d-%Y-%H:%M:%S)
    wl-screenrec -g "$geometry" --audio -f ~/Videos/recordings/$dateTime.mp4 &
    notify-send "Recording started"
  fi
fi
