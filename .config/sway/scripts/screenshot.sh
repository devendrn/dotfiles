#!/bin/bash

STAMP=$(date +"%y-%m-%d-%H-%M")
PIC="$HOME/Screenshots/ss-${STAMP}.png"

# grim -g "$(slurp -o)" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')
grim -g "$(slurp -o)" $PIC

if [ -f "$PIC" ]; then
  notify-send -i $PIC "Screenshot saved. Copied to clipboard." 
  wl-copy < $PIC
fi
