#!/usr/bin/env bash

if [[ "$(mpc status "%state%")" = "playing" ]]; then
  echo $(mpc --format " %albumArtist% - %title% \[%album%\]" current)
elif [[ "$(mpc status "%state%")" = "paused" ]]; then
  echo $(mpc --format " %albumArtist% - %title% \[%album%\]" current)
elif [[ "$(mpc status "%state%")" = "stopped" ]]; then
  echo
fi
