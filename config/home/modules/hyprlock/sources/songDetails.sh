#!/usr/bin/env bash

if [[ "$(mpc status "%state%")" = "playing" ]]; then
  mpc --format "󰏤 %albumArtist% - %title% \[%album%\]" current
elif [[ "$(mpc status "%state%")" = "paused" ]]; then
  mpc --format "󰐊 %albumArtist% - %title% \[%album%\]" current
elif [[ "$(mpc status "%state%")" = "stopped" ]]; then
  echo
fi
