#!/usr/bin/env bash

threshold=80
alerts=$(df -h | awk -v t=$threshold '$5+0 > t {print $6, $5}')

if [[ -n "$alerts" ]]; then
  while read -r mount usage; do
    notify-send "Disk Alert" "$mount is $usage full!"
  done <<< "$alerts"
fi
