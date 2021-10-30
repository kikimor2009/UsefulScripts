#!/usr/bin/bash

builtin=$(iw wlan0 info | grep "addr" | cut -d ' ' -f2)

iw dev | grep -e "wlan[1-9]\|addr" | grep -v "$builtin" | cut -d ' ' -f2
