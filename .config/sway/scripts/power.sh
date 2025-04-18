#!/bin/bash

selection=$(printf "  Suspend\n󰍃  Lock\n󰐥  Power Off\n󰜉  Reboot" | fuzzel -d --width 10 --lines 4)

case $selection in 
  "  Suspend") systemctl suspend;;
  "󰍃  Lock") swaylock;;
  "󰐥  Power Off") systemctl poweroff;;
  "󰜉  Reboot") systemctl reboot;;
  *) exit 1 ;;
esac

