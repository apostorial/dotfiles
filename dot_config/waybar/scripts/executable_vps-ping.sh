#!/bin/bash

HOST="themoroccandemonlist.com"

while true; do
  if ping -c 1 -W 2 $HOST >/dev/null 2>&1; then
    echo '{"text": "VPS: Up", "class": "up"}'
  else
    echo '{"text": "VPS: Down", "class": "down"}'
  fi
  sleep 30
done
