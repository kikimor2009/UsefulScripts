#!/usr/bin/bash

if [[ $# -eq 3 ]]; then
  echo "Dump traffic with filter by MAC."
  tcpdump -i "$1" -w "$2" ether host "$3"
elif [[ $# -eq 2 ]]; then
  echo "Just dump traffic."
  tcpdump -i "$1" -w "$2"
else
  echo "Unknown mode."
fi

