#!/usr/bin/env bash

while true; do
  percentage=$(upower -d | rg --trim --max-count=1 percentage | sed 's/percentage:\s*\(.*\)%/\1/')
  state=$(upower -d | rg --trim --max-count=1 state | sed 's/state:\s*\([A-Za-z]\)/\1/')
  
  if [[ $(("$percentage")) -le 5 && "$state" = "discharging" ]]; then
    notify-send --urgency=critical "Battery at 5%" "Hibernating in 60 seconds"
    sleep 60s
    systemctl hibernate
  elif [[ $(("$percentage")) -le 10 && "$state" = "discharging" ]]; then
    notify-send --urgency=critical "Battery at 10%" "Device will hibernate at 5%"
  elif [[ $(("$percentage")) -le 20 && "$state" = "discharging" ]]; then
    notify-send "Battery at 20%" "Plug in your device"
  fi

  sleep 60s

done
