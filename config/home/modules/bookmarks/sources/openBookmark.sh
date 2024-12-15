#!/usr/bin/env bash

BIFS="$IFS"
IFS=$'\n'

configLocation="$HOME/openBookmark"
BOOKMARKS="$HOME/Documents/Personal/bookmarks.json"

declare -a names
declare -a urls
for i in $(seq 0 $(($(jq -r "length" "$BOOKMARKS")-1))); do
  mapfile -t tempNames < <(jq --sort-keys -r --arg i "$i" ".[keys[$i]] | keys[]" "$BOOKMARKS")
  mapfile -t tempUrls < <(jq --sort-keys -r --arg i 1 ".[keys[$i]]" "$BOOKMARKS" | jq --sort-keys -r --arg i 1 ".[]")
  names+=("${tempNames[@]}")
  urls+=("${tempUrls[@]}")
done

# Add newline to each entry
names=("${names[@]/%/'\n'}")
urls=("${urls[@]/%/'\n'}")

# Get a choice from wofi, save its index number
index=$(echo -e "${names[@]}" | wofi -c "$configLocation" --define=dmenu-print_line_num=true --show dmenu)

# Only opens if index is declared:
# prevents something from opening when wofi is exited with esc
if [[ "$index" =~ ^[0-9]+$ ]] && ((index >= 0 && index < ${#urls[@]})); then
  xdg-open "${urls[$index]}"
else
  echo "Invalid selection or no selection made. Exiting."
fi

IFS="$BIFS"
