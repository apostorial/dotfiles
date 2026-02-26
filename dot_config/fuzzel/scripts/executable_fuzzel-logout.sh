#!/bin/bash

SELECTION="$(printf \
'Shutdown\nReboot\nLog out\nSuspend\nLock' \
| fuzzel --dmenu)"

case "$SELECTION" in
    *Shutdown)  systemctl poweroff ;;
    *Reboot)    systemctl reboot ;;
    *Log\ out)  hyprctl dispatch exit ;;
    *Suspend)   systemctl suspend ;;
    *Lock)      hyprlock ;;
    *) exit ;;
esac
