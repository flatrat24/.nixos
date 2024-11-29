#!/usr/bin/env bash

currentState=$(bluetoothctl show | rg --trim Powered: | sed 's/\s*Powered:\s*\([a-z]\{2,3\}\).*/\1/')

if [ "$currentState" = "no" ]; then
  bluetoothctl power on
else
  bluetoothctl power off
fi
