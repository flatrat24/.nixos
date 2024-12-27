#!/usr/bin/env bash

##--- Functions ---##
generate_messages () { jq --raw-output --sort-keys 'to_entries[] | .value | to_entries[] | "<span weight='\''bold'\''>\(.key)</span> <span weight='\''light'\'' style='\''italic'\''>\(.value)</span>"' "$SORTED_JSON"; }

if ! VALID_ARGS=$(getopt -o muksoc --long generate-messages,list-urls,list-keys,select-bookmark,open-bookmark,create-bookmark -- "$@")
then
  exit 1;
fi

# Sort the JSON file by keys at all levels and cache it in a temporary file
SORTED_JSON=$(mktemp)
jq --sort-keys '.' "$BOOKMARKS/bookmarks.json" > "$SORTED_JSON"

eval set -- "$VALID_ARGS"
while [ "$#" -gt 0 ]; do
  case "$1" in
    -m | --generate-messages)
      generate_messages
      shift
      ;;

    -u | --list-urls)
      jq --raw-output --sort-keys '.[] | keys | .[]' "$SORTED_JSON"
      shift
      ;;

    -k | --list-keys)
      jq --raw-output --sort-keys '.[] | .[]' "$SORTED_JSON"
      shift
      ;;

    -s | --select-bookmark)
      generate_messages | wofi -d | grep -oP "<span[^>]*>.*</span> <span[^>]*>\K.*?(?=</span>)"
      shift
      ;;

    -o | --open-bookmark)
      xdg-open "$(generate_messages | wofi -d --define=width=40% | grep -oP "<span[^>]*>.*</span> <span[^>]*>\K.*?(?=</span>)")"
      shift
      ;;

    -c | --create-bookmark)
      title=$(wofi --define=prompt='title' --define=width=20% --define=height=48 --show dmenu)
      if [[ -z "$title" ]]; then
        notify-send "No Bookmark Created" "Title was not specified"
        exit 1
      fi

      url=$(wofi --define=prompt='url' --define=width=20% --define=height=48 --show dmenu)
      if [[ -z "$url" ]]; then
        notify-send "No Bookmark Created" "URL was not specified"
        exit 1
      fi

      category=$(jq --sort-keys -r "keys[]" "$BOOKMARKS/bookmarks.json" | wofi --define=prompt='category' --define=width=15% --define=height=25% --show dmenu)
      if [[ -z "$category" ]]; then
        notify-send "No Bookmark Created" "Category was not specified"
        exit 1
      fi

      temp_bookmarks=$(mktemp)
      jq --argjson url "\"$url\"" --arg title "$title" '.[$category][$title] = $url' --arg category "$category" "$BOOKMARKS/bookmarks.json" > "$temp_bookmarks"
      cp "$temp_bookmarks" "$BOOKMARKS/bookmarks.json"

      notify-send "Created New Bookmark" "$title in $category"

      cd "$BOOKMARKS" || exit 1
      git add bookmarks.json
      git commit -m "+$title in $category"
      shift
      ;;

    --) shift;
      break 
      ;;
  esac
done
