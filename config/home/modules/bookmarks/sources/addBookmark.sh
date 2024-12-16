#!/usr/bin/env bash

config="$BOOKMARKS/sources/addBookmark"

title=$(wofi -c $config --define=prompt='title' --show dmenu)
if [[ -z "$title" ]]; then
  notify-send "No Bookmark Created" "Title was not specified"
  exit 1
fi

url=$(wofi -c $config --define=prompt='url' --show dmenu)
if [[ -z "$url" ]]; then
  notify-send "No Bookmark Created" "URL was not specified"
  exit 1
fi

category=$(jq --sort-keys -r "keys[]" "$BOOKMARKS" | wofi -c $config --define=lines=10 --define=width=15% --define=prompt='category' --show dmenu)
if [[ -z "$category" ]]; then
  notify-send "No Bookmark Created" "Category was not specified"
  exit 1
fi

jq --argjson url "\"$url\"" --arg title "$title" '.[$category][$title] = $url' --arg category "$category" "$BOOKMARKS" > "$(dirname "$BOOKMARKS")"/temp_bookmarks.json
mv "$(dirname "$BOOKMARKS")/temp_bookmarks.json" "$BOOKMARKS"
notify-send "Created New Bookmark" "$title in $category"
