#!/usr/bin/env bash

# get the bookmarks from the current course's info.json file
mapfile -t messages< <(jq --sort-keys -r '.bookmarks | keys[]' "$(courseInfo.sh --path)"/info.json)
mapfile -t commands< <(jq --sort-keys -r '.bookmarks[]' "$(courseInfo.sh --path)"/info.json | sed "s/^\(.*\)$/xdg-open '\1'/")

# add generic 'bookmarks' that apply to all courses
messages+=("Open in Terminal")
commands+=("foot -D $(courseInfo.sh --path)")

messages+=("Open in File Browser")
commands+=("xdg-open '$(courseInfo.sh --path)'")

messages+=("View Course Notes (Full Compile)")
commands+=("courseTools.sh --update-main-full && cd $(courseInfo.sh --path)/notes && pdflatex --shell-escape ./main.tex && pdflatex --shell-escape ./main.tex && courseTools.sh -c && xdg-open ./main.pdf")

messages+=("View Course Notes (Don't Compile)")
commands+=("xdg-open $(courseInfo.sh --path)/notes/main.pdf")

messages+=("Clean Directory")
commands+=("courseTools.sh -C")

# ask wofi to select one of them, and return the number of the selection
selection=$(printf "%s\n" "${messages[@]}" | wofi --define=dmenu-print_line_num=true --define=lines=10 --prompt="$(courseInfo.sh --title)" -d)

# verify that the user made a selection ($selection must be an integer)
if ! [[ "$selection" =~ ^[0-9]+$ ]]
then
  echo "Error: No selection was made"
  exit 1
fi

# run the chosen command
eval "${commands[$selection]}"
