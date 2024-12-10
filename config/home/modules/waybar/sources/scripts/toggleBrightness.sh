#!/usr/bin/env bash

current_brightness=$(brightnessctl -m | grep -oP '\d+(?=%)')

if [ "$current_brightness" -gt 50 ]; then
    brightnessctl set 0%
else
    brightnessctl set 100%
fi
