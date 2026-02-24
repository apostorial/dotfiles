#!/bin/bash

SELECTION="$(printf \
'Lock\nSuspend\nLog out\nReboot\nShutdown' \
| fuzzel --dmenu)"

case "$SELECTION" in
    *Lock)      hyprlock ;;
    *Suspend)   systemctl suspend ;;
    *Log\ out)  hyprctl dispatch exit ;;
    *Reboot)    systemctl reboot ;;
    *Shutdown)  systemctl poweroff ;;
    *) exit ;;
esac
