#!/bin/bash

#WALLPAPER_DIR="$HOME/Wallpapers"
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
  local wallpaper_path="$1"
  prev_swaybg_ps="$(pgrep swaybg)"
  swaybg --image "$wallpaper_path" &
  sleep 0.40
  if [ -n "$prev_swaybg_ps" ]; then
    kill $prev_swaybg_ps
  fi
  #swaymsg output \* bg "$wallpaper_path" fill
}

wallpapers_array=()
while IFS= read -r -d $'\0' wallpaper; do
  wallpapers_array+=("$wallpaper")
done < <(get_wallpapers)

wallpaper_count="${#wallpapers_array[@]}"

if [ "$wallpaper_count" -eq 0 ]; then
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

current_index=$(get_current_index)

argument="$1"
if [ "$argument" == "--next" ]; then
  if [[ "$current_index" =~ ^[0-9]+$ ]]; then # check if valid number
    next_index=$((current_index + 1))
    if [ "$next_index" -ge "$wallpaper_count" ]; then
      index=0
    else
      index="$next_index"
    fi
  else
    index=0
  fi
elif [ "$argument" == "--prev" ]; then
  if [[ "$current_index" =~ ^[0-9]+$ ]]; then # check if valid number
    prev_index=$((current_index - 1))
    if [ "$prev_index" -lt 0 ]; then
      index=$((wallpaper_count - 1))
    else
      index="$prev_index"
    fi
  else
    index=$((wallpaper_count - 1))
  fi
else
  index=$((RANDOM % wallpaper_count)) # random index on normal run
fi

if [ "$index" -ge 0 ] && [ "$index" -lt "$wallpaper_count" ]; then
  selected_wallpaper="${wallpapers_array[$index]}"
  set_wallpaper "$selected_wallpaper"
  set_current_index "$index"
else
  echo "Error: Invalid wallpaper index: $index"
  exit 1
fi

exit 0
