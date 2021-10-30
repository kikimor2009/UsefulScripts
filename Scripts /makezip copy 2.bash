#!/usr/bin/env bash

chmod -R 777 ./*

rev=99

if [ -n "$1" ]; then
  rev=$1
fi

num=$(grep revision ./Files/wgs/scripts/version.txt | cut -d ' ' -f2)

sed -i "2s/$num/$rev/" ./Files/wgs/scripts/version.txt

zip --password Fzgd/3cFJU~\(yYpGc4g: updater_PA_094.$rev.zip -r ./*
