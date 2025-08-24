#!/bin/bash

SELECTION=$(printf "  Suspend\n󰍃  Lock\n󰐥  Power Off\n󰜉  Reboot" | fuzzel -d --width 10 --lines 4)

case $SELECTION in 
  "  Suspend") systemctl suspend;;
  "󰍃  Lock") $HOME/.config/sway/scripts/lock.sh;;
  "󰐥  Power Off") systemctl poweroff;;
  "󰜉  Reboot") systemctl reboot;;
  *) exit 1 ;;
esac

