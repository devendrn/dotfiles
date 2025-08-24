#!/bin/bash

WALLPAPER_DIR="$HOME/Wallpapers"
INDEX_FILE="$WALLPAPER_DIR/.current.txt"

if [ ! -d "$WALLPAPER_DIR" ]; then
  mkdir -p "$WALLPAPER_DIR"
  echo "Created wallpaper directory: $WALLPAPER_DIR"
fi

get_wallpapers() {
  find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0 | sort -z
}

set_wallpaper() {
  local WALLPAPER_PATH="$1"
  PREV_SWAYBG_PS="$(pgrep swaybg)"
  swaybg --image "$WALLPAPER_PATH" &
  sleep 0.30
  if [ -n "$PREV_SWAYBG_PS" ]; then
    kill $PREV_SWAYBG_PS
  fi
  #swaymsg output \* bg "$WALLPAPER_PATH" fill
}

WALLPAPERS_ARRAY=()
while IFS= read -r -d $'\0' WALLPAPER; do
  WALLPAPERS_ARRAY+=("$WALLPAPER")
done < <(get_wallpapers)

WALLPAPER_COUNT="${#WALLPAPERS_ARRAY[@]}"

if [ "$WALLPAPER_COUNT" -eq 0 ]; then
  exit 1
fi

get_current_index() {
  if [ -f "$INDEX_FILE" ]; then
    cat "$INDEX_FILE"
  else
    echo "-1" # no index file
  fi
}

set_current_index() {
  echo "$1" > "$INDEX_FILE"
}

CURRENT_INDEX=$(get_current_index)

ARGUMENT="$1"
if [ "$ARGUMENT" == "--next" ]; then
  if [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]]; then # check if valid number
    NEXT_INDEX=$((CURRENT_INDEX + 1))
    if [ "$NEXT_INDEX" -ge "$WALLPAPER_COUNT" ]; then
      INDEX=0
    else
      INDEX="$NEXT_INDEX"
    fi
  else
    INDEX=0
  fi
elif [ "$ARGUMENT" == "--prev" ]; then
  if [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]]; then # check if valid number
    PREV_INDEX=$((CURRENT_INDEX - 1))
    if [ "$PREV_INDEX" -lt 0 ]; then
      INDEX=$((WALLPAPER_COUNT - 1))
    else
      INDEX="$PREV_INDEX"
    fi
  else
    INDEX=$((WALLPAPER_COUNT - 1))
  fi
else
  INDEX=$((RANDOM % WALLPAPER_COUNT)) # random index on normal run
fi

if [ "$INDEX" -ge 0 ] && [ "$INDEX" -lt "$WALLPAPER_COUNT" ]; then
  SELECTED_WALLPAPER="${WALLPAPERS_ARRAY[$INDEX]}"
  set_wallpaper "$SELECTED_WALLPAPER"
  set_current_index "$INDEX"
else
  echo "Error: Invalid wallpaper INDEX: $INDEX"
  exit 1
fi

exit 0
