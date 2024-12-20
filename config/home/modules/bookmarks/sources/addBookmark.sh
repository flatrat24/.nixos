#!/usr/bin/env bash

config="$BOOKMARKS/sources/addBookmark"

title=$(wofi -c $config --define=prompt='title' --define=width=25% --show dmenu)
if [[ -z "$title" ]]; then
  notify-send "No Bookmark Created" "Title was not specified"
  exit 1
fi

url=$(wofi -c $config --define=prompt='url' --show dmenu)
if [[ -z "$url" ]]; then
  notify-send "No Bookmark Created" "URL was not specified"
  exit 1
fi

category=$(jq --sort-keys -r "keys[]" "$BOOKMARKS/bookmarks.json" | wofi -c $config --define=height=25% --define=width=15% --define=prompt='category' --show dmenu)
if [[ -z "$category" ]]; then
  notify-send "No Bookmark Created" "Category was not specified"
  exit 1
fi

temp_bookmarks=$(mktemp)
jq --argjson url "\"$url\"" --arg title "$title" '.[$category][$title] = $url' --arg category "$category" "$BOOKMARKS/bookmarks.json" > "$temp_bookmarks"
cp "$temp_bookmarks" "$BOOKMARKS/bookmarks.json"

cd $BOOKMARKS
git add bookmarks.json
git commit -c "+$title in $category"

notify-send "Created New Bookmark" "$title in $category"
