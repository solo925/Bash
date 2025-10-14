#!/usr/bin/env bash
city=$1
curl -s "https://wttr.in/$city?format=3"
