#!/usr/bin/env bash

##--- User chooses entry to use ---##
entries=()
while IFS= read -r entry; do
  entries+=("$(realpath --relative-to="$HOME/.password-store" "$entry" | sed 's/\.gpg$//')")
done < <(fd --no-hidden --type file . "$HOME/.password-store")

entrySelection=$(printf "%s\n" "${entries[@]}" | wofi --define=lines=7 --prompt="password store" -d)

buf=$(mktemp)
pass show "$entrySelection" >> "$buf"

##--- Parse the file into arrays ---##
passwords=()
usernames=()
emails=()
comments=()

readingAComment=false
currentComment=""
while read -r line; do
  if $readingAComment && echo "$line" | grep -Eq "^\s*.*$"; then
    currentComment+="$line\n"
    echo -e "$currentComment"
  else
    if echo "$line" | grep -Eq "^username: .*"; then
      usernames+=("${line//username: /}")
      if $readingAComment; then
        comments+=("$currentComment")
        currentComment=""
        readingAComment=false
      fi
    elif echo "$line" | grep -Eq "^email: .*"; then
      emails+=("${line//email: /}")
      if $readingAComment; then
        comments+=("$currentComment")
        currentComment=""
        readingAComment=false
      fi
    elif echo "$line" | grep -Eq "^--$"; then
      comments+=("$currentComment")
      currentComment=""
      readingAComment=false
    elif echo "$line" | grep -Eq "^comments:$"; then
      readingAComment=true
    else
      passwords+=("$line")
      if $readingAComment; then
        comments+=("$currentComment")
        currentComment=""
        readingAComment=false
      fi
    fi
  fi
done <"$buf"

if [ -z "$currentComment" ]; then
  comments+=("$currentComment")
fi

##--- Let the user choose what they want to copy ---##
if [ "${#passwords[@]}" == 1 ]; then
  fieldOptions=("passwords" "usernames" "emails" "comments")
  fieldSelection=$(printf "%s\n" "${fieldOptions[@]}" | wofi --define=lines="$((${#fieldOptions[@]} + 2))" --prompt="$entrySelection" -d)
  echo -e "${!fieldSelection[0]}" | wl-copy
else
  accountSelection=$(printf "%s\n" "${emails[@]}" | wofi --define=lines="$((${#emails[@]} + 2))" --define=dmenu-print_line_num=true --prompt="choose an account" -d)

  fieldOptions=("passwords" "usernames" "emails" "comments")
  fieldSelection=$(printf "%s\n" "${fieldOptions[@]}" | wofi --define=lines="$((${#fieldOptions[@]} + 2))" --prompt="$entrySelection" -d)
  echo -e "${!fieldSelection["$accountSelection"]}" | wl-copy
fi

##--- Make sure to shred tempfile ---##
shred "$buf"
