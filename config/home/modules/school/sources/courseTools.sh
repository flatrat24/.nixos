#!/usr/bin/env bash

echoHelpMessage () {
  echo "courseTools - perform actions related to couses"
  echo
  echo "Manipulate course directories from the command line. Prioritizes performing"
  echo "actions over fetching information."
  echo
  echo "Usage: courseTools [DIRECTORY] [options]"
  echo "  Specifying the directory of the course is optional, and if no directory"
  echo "  is specified, the program will work with the current course information."
  echo "  Specified directories should be the direct parent of the info.json file."
  echo
  echo "Available Options:"
  echo "  -c, --clean                   Remove all files except for .pdf and .tex. These"
  echo "                                usually come from compiling tex files with pdflatex"
  echo "  -C, --full-clean              Remove all files except for .tex. These usually"
  echo "                                come from compiling tex files with pdflatex"
  echo "  -f, --create-figure           Takes a single argument as a path to a figure template."
  echo "                                Copies the template into the next figure in the"
  echo "                                current course's notes/figures/ directory."
  echo "  -F, --create-basic-figure     Copies the basic_figure.tex template from the templates/"
  echo "                                directory into the next figure in the current course's"
  echo "                                notes/figures/ directory."
  echo "  -l, --create-lecture          Takes a single argument as a path to a lecture template."
  echo "                                Copies the template into the next lecture in the"
  echo "                                current course's notes/ directory."
  echo "  -L, --create-basic-lecture    Copies the basic_lecture.tex template from the templates/"
  echo "                                directory into the next lecture in the current course's"
  echo "                                notes/ directory."
  echo "  -a, --auto-course             Read course information from info.json files in course"
  echo "                                directories and automatically update current course if"
  echo "                                applicable"
  echo "  -s, --set-course [DIRECTORY]  Sets the current course to DIRECTORY. DIRECTORY must be"
  echo "                                a child of \$CURRENTCOURSE environment variable."
  echo "      --update-main-full        Updates the main.tex file to include all lectures in"
  echo "                                the shared directory."
  echo "      --update-main-new [n]     Updates the main.tex file to include n lectures in the"
  echo "                                shared directory, including the newest lectures first."
  echo "      --update-main-old [n]     Updates the main.tex file to include n lectures in the"
  echo "                                shared directory, including the oldest lectures first."
  echo "      --edit-current-lecture    Opens the most recent lecture with xdg-open"
}

if [[ -d "$1" ]]; then
  if [[ $(find "$1" -maxdepth 1 -mindepth 1 -type f -name info.json | wc -l) = 1 ]]; then
    courseDirectory="$(pwd)/$1"
    shift
  else
    echo "Invalid directory: Specified directory must be direct parent to info.json file"
    exit 1
  fi
else
  courseDirectory=$(courseInfo.sh --path)
fi

if ! VALID_ARGS=$(getopt -o hcCf:Fl:Las: --long clean,full-clean,create-figure:,create-basic-figure,create-lecture:,create-basic-lecture,auto-course,set-course:,update-main-full,update-main-new:,update-main-old:,edit-current-lecture -- "$@")
then
  exit 1;
fi

eval set -- "$VALID_ARGS"
while [ "$#" -gt 0 ]; do
  case "$1" in
    -c | --clean)
      # for file in $(find "$courseDirectory/notes" -mindepth 1 -maxdepth 1 -type f -name "*.*" ! -name "*.tex" ! -name "*.pdf"); do 
      #   rm "$file"
      # done
      while IFS= read -r -d '' file
      do
        rm "$file"
      done <   <(find "$courseDirectory/notes" -mindepth 1 -maxdepth 1 -type f -name "*.*" ! -name "*.tex" ! -name "*.pdf" -print0)

      shift
      ;;

    -C | --full-clean)
      # for file in $(find "$courseDirectory/notes" -mindepth 1 -maxdepth 1 -type f -name "*.*" ! -name "*.tex"); do 
      #   rm "$file"
      # done
      while IFS= read -r -d '' file
      do
        rm "$file"
      done <   <(find "$courseDirectory/notes" -mindepth 1 -maxdepth 1 -type f -name "*.*" ! -name "*.tex" -print0)
      shift
      ;;

    -f | --create-figure)
      templatePath="$2"
      if [[ -f "$CURRENTQUARTER/xlatex/templates/figure/$(basename "$templatePath")" ]]; then
        newPath="$(courseInfo.sh --next-figure)"
        cp "$templatePath" "$newPath"

        titleLineNumber=$(grep -n "\\\title{" "$newPath" | cut -d : -f 1)
        newTitle=$(echo "$newPath" | sed 's/.*\/fig_\([0-9]\{3\}\)\.tex/Figure \1/')
        sed -i "$(("$titleLineNumber"))s/\(\\\title{\).*\(}\)/\1$newTitle\2/" "$newPath"

        dateLineNumber=$(grep -n "\\\date{" "$newPath" | cut -d : -f 1)
        newDate=$(date +"%B %d, %Y")
        sed -i "$((dateLineNumber))s/\(\\\date{\).*\(}\)/\1$newDate\2/" "$newPath"

        notify-send "Figure Created in $(courseInfo.sh --short)" "$(basename "$newPath")"
      else
        echo "Error: template doesn't exist"
        exit 1
      fi
      shift
      shift
      ;;

    -F | --create-basic-figure)
      templatePath="$CURRENTQUARTER/xlatex/templates/figure/basic_figure.tex"
      if [[ -f "$templatePath" ]]; then
        newPath="$(courseInfo.sh --next-figure)"
        cp "$templatePath" "$newPath"

        titleLineNumber=$(grep -n "\\\title{" "$newPath" | cut -d : -f 1)
        newTitle=$(echo "$newPath" | sed 's/.*\/fig_\([0-9]\{3\}\)\.tex/Figure \1/')
        sed -i "$(("$titleLineNumber"))s/\(\\\title{\).*\(}\)/\1$newTitle\2/" "$newPath"

        dateLineNumber=$(grep -n "\\\date{" "$newPath" | cut -d : -f 1)
        newDate=$(date +"%B %d, %Y")
        sed -i "$((dateLineNumber))s/\(\\\date{\).*\(}\)/\1$newDate\2/" "$newPath"

        notify-send "Figure Created in $(courseInfo.sh --short)" "$(basename "$newPath")"
      else
        echo "Error: basic_figure.tex doesn't exist"
        exit 1
      fi
      shift
      ;;

    -l | --create-lecture)
      templatePath="$(pwd)/$2"
      if [[ -f "$CURRENTQUARTER/xlatex/templates/lecture/$(basename "$templatePath")" ]]; then
        newPath="$(courseInfo.sh --next-lecture)"
        cp "$templatePath" "$newPath"

        titleLineNumber=$(grep -n "\\\title{" "$newPath" | cut -d : -f 1)
        newTitle=$(echo "$newPath" | sed 's/.*\/lec_\([0-9]\{3\}\)\.tex/Lecture \1/')
        sed -i "$(("$titleLineNumber"))s/\(\\\title{\).*\(}\)/\1$newTitle\2/" "$newPath"

        dateLineNumber=$(grep -n "\\\date{" "$newPath" | cut -d : -f 1)
        newDate=$(date +"%B %d, %Y")
        sed -i "$((dateLineNumber))s/\(\\\date{\).*\(}\)/\1$newDate\2/" "$newPath"

        notify-send "Lecture Created in $(courseInfo.sh -short)" "$(basename "$newPath")"
      else
        echo "Error: template doesn't exist"
        exit 1
      fi
      shift
      shift
      ;;

    -L | --create-basic-lecture)
      templatePath="$CURRENTQUARTER/xlatex/templates/lecture/basic_lecture.tex"
      if [[ -f "$templatePath" ]]; then
        newPath="$(courseInfo.sh --next-lecture)"
        cp "$templatePath" "$newPath"

        titleLineNumber=$(grep -n "\\\title{" "$newPath" | cut -d : -f 1)
        newTitle=$(echo "$newPath" | sed 's/.*\/lec_\([0-9]\{3\}\)\.tex/Lecture \1/')
        sed -i "$(("$titleLineNumber"))s/\(\\\title{\).*\(}\)/\1$newTitle\2/" "$newPath"

        dateLineNumber=$(grep -n "\\\date{" "$newPath" | cut -d : -f 1)
        newDate=$(date +"%B %d, %Y")
        sed -i "$((dateLineNumber))s/\(\\\date{\).*\(}\)/\1$newDate\2/" "$newPath"

        notify-send "Lecture Created in $(courseInfo.sh --short)" "$(basename "$newPath")"
      else
        echo "Error: basic_lecture.tex doesn't exist"
        exit 1
      fi
      shift
      ;;

    -a | --auto-course)
      newCourseDirectory=1

      time=$(date +"%H%M" | sed 's/^0*//')
      day=$(date +"%a")

      mapfile -t coursePaths < <(find "$CURRENTQUARTER" -mindepth 1 -maxdepth 1 -type d ! -name xlatex)
      for path in "${coursePaths[@]}"; do
        start=$(courseInfo.sh "$path" --start)
        end=$(courseInfo.sh "$path" --end)
        days="$(courseInfo.sh "$path" --days)"

        if [[ $start -le $time && $end -gt $time && $days =~ $day ]]; then
          newCourseDirectory="$path"
          break
        fi

        if [[ "$(courseInfo.sh "$path" --has-lab)" = true ]]; then
          labStart=$(courseInfo.sh "$path" --lab-start)
          labEnd=$(courseInfo.sh "$path" --lab-end)
          labDays="$(courseInfo.sh "$path" --lab-days)"

          if [[ $labStart -le $time && $labEnd -gt $time && $labDays =~ $day ]]; then
            newCourseDirectory="$path"
            break
          fi
        fi
      done

      if [ -d "$newCourseDirectory" ]; then
        ln -sfn "$newCourseDirectory" "$CURRENTCOURSE"
        title=$(courseInfo.sh -t)
        short=$(courseInfo.sh -s)
        notify-send "Current Course Changed" "$short - $title"
      else
        title=$(courseInfo.sh -t)
        short=$(courseInfo.sh -s)
        notify-send "Current Course Unchanged" "$short - $title"
      fi
      shift
      ;;

    -s | --set-course)
      newCourseDirectory="$(pwd)/$2"

      # verify that it's a real course directory
      if [ ! -f "$newCourseDirectory/info.json" ]; then
        echo "Error: Directory does not contain an info.json file."
        title=$(courseInfo.sh --title)
        short=$(courseInfo.sh --short)
        notify-send "Current Course Unchanged" "$short - $title"
        exit 1
      fi

      ln -sfn "$newCourseDirectory" "$CURRENTCOURSE"
      title=$(courseInfo.sh --title)
      short=$(courseInfo.sh --short)
      notify-send "Current Course Changed" "$short - $title"

      shift
      shift
      ;;

    --update-main-full)
      startLineNumber=$(grep -n "% start lectures" "$courseDirectory/notes/main.tex" | cut -d : -f 1)
      if ! [[ "$startLineNumber" =~ ^[0-9]+$ ]] ; then
        echo "error: couldn't find start of lectures in main.tex"
        exit 1
      fi
      endLineNumber=$(grep -n "% end lectures" "$courseDirectory/notes/main.tex" | cut -d : -f 1)
      if ! [[ "$endLineNumber" =~ ^[0-9]+$ ]] ; then
        echo "error: couldn't find end of lectures in main.tex"
        exit 1
      fi
      if [[ $((startLineNumber)) -ge $((endLineNumber)) ]]; then
        echo "error: end of lectures exists before start of lectures"
        exit 1
      fi
      if ! [[ $((startLineNumber + 1)) -eq $((endLineNumber)) ]]; then
        sed -i "$((startLineNumber + 1)),$((endLineNumber - 1))d" "$courseDirectory/notes/main.tex"
      fi
      mapfile -t fileNames < <(find "$(courseInfo.sh --path)/notes" -mindepth 1 -maxdepth 1 -name '*.tex' ! -name 'main.tex' | sed 's/.*\/\([^\.]*\)\.tex/\1/' | sort)
      for i in "${!fileNames[@]}"; do
        sed -i "$((startLineNumber + 1 + i))i\  \\\input{${fileNames[$i]}}" "$courseDirectory/notes/main.tex"
      done
      shift
      ;;

    --update-main-new)
      startLineNumber=$(grep -n "% start lectures" "$courseDirectory/notes/main.tex" | cut -d : -f 1)
      if ! [[ "$startLineNumber" =~ ^[0-9]+$ ]] ; then
        echo "error: couldn't find start of lectures in main.tex"
        exit 1
      fi
      endLineNumber=$(grep -n "% end lectures" "$courseDirectory/notes/main.tex" | cut -d : -f 1)
      if ! [[ "$endLineNumber" =~ ^[0-9]+$ ]] ; then
        echo "error: couldn't find end of lectures in main.tex"
        exit 1
      fi
      if [[ $((startLineNumber)) -ge $((endLineNumber)) ]]; then
        echo "error: end of lectures exists before start of lectures"
        exit 1
      fi
      if ! [[ $((startLineNumber + 1)) -eq $((endLineNumber)) ]]; then
        sed -i "$((startLineNumber + 1)),$((endLineNumber - 1))d" "$courseDirectory/notes/main.tex"
      fi
      n=$2
      mapfile -t fileNames < <(find "$(courseInfo.sh --path)/notes" -mindepth 1 -maxdepth 1 -name '*.tex' ! -name 'main.tex' | sed 's/.*\/\([^\.]*\)\.tex/\1/' | sort)
      if [[ ${#fileNames[@]} -gt $n ]]; then
        for i in $(seq 0 $((n - 1))); do
          sed -i "$((startLineNumber + 1 + i))i\  \\\input{${fileNames[$((${#fileNames[@]} - n + i))]}}" "$courseDirectory/notes/main.tex"
        done
      else
        for i in "${!fileNames[@]}"; do
          sed -i "$((startLineNumber + 1 + i))i\  \\\input{${fileNames[$i]}}" "$courseDirectory/notes/main.tex"
        done
      fi
      shift
      shift
      ;;

    --update-main-old)
      startLineNumber=$(grep -n "% start lectures" "$courseDirectory/notes/main.tex" | cut -d : -f 1)
      if ! [[ "$startLineNumber" =~ ^[0-9]+$ ]] ; then
        echo "error: couldn't find start of lectures in main.tex"
        exit 1
      fi
      endLineNumber=$(grep -n "% end lectures" "$courseDirectory/notes/main.tex" | cut -d : -f 1)
      if ! [[ "$endLineNumber" =~ ^[0-9]+$ ]] ; then
        echo "error: couldn't find end of lectures in main.tex"
        exit 1
      fi
      if [[ $((startLineNumber)) -ge $((endLineNumber)) ]]; then
        echo "error: end of lectures exists before start of lectures"
        exit 1
      fi
      if ! [[ $((startLineNumber + 1)) -eq $((endLineNumber)) ]]; then
        sed -i "$((startLineNumber + 1)),$((endLineNumber - 1))d" "$courseDirectory/notes/main.tex"
      fi
      n=$2
      mapfile -t fileNames < <(find "$(courseInfo.sh --path)/notes" -mindepth 1 -maxdepth 1 -name '*.tex' ! -name 'main.tex' | sed 's/.*\/\([^\.]*\)\.tex/\1/' | sort)
      if [[ ${#fileNames[@]} -gt $n ]]; then
        for i in $(seq 0 $((n - 1))); do
          sed -i "$((startLineNumber + 1 + i))i\  \\\input{${fileNames[$i]}}" "$courseDirectory/notes/main.tex"
        done
      else
        for i in "${!fileNames[@]}"; do
          sed -i "$((startLineNumber + 1 + i))i\  \\\input{${fileNames[$i]}}" "$courseDirectory/notes/main.tex"
        done
      fi
      shift
      shift
      ;;

    --edit-current-lecture)
      lecturePath=$(courseInfo.sh --last-lecture)
      xdg-open "$lecturePath"
      shift
      ;;

    -h | --help)
      echoHelpMessage
      shift
      ;;

    --) shift; 
      break 
      ;;
  esac
done
