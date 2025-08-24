#!/bin/bash

WALLPAPER_DIR="$HOME/Wallpapers"
INDEX_FILE="$WALLPAPER_DIR/.current.txt"

get_wallpapers() {
  find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0 | sort -z
}

WALLPAPERS_ARRAY=()
while IFS= read -r -d $'\0' WALLPAPER; do
  WALLPAPERS_ARRAY+=("$WALLPAPER")
done < <(get_wallpapers)

WALLPAPER_COUNT="${#WALLPAPERS_ARRAY[@]}"

get_current_index() {
  if [ -f "$INDEX_FILE" ]; then
    cat "$INDEX_FILE"
  else
    echo "1" # choose first image other wise
  fi
}

WALLPAPER_ARG=""
INDEX=$(get_current_index)
if [ "$INDEX" -ge 0 ] && [ "$INDEX" -lt "$WALLPAPER_COUNT" ]; then
  WALLPAPER_ARG="-i ${WALLPAPERS_ARRAY[$INDEX]}"
fi

swaylock -f --indicator-idle-visible ${WALLPAPER_ARG} -F
