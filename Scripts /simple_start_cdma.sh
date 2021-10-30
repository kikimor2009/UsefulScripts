#!/bin/bash

./cdma_ref < <(\
    while true ; do \
      if [ -e "rfon.txt" ]; then \
        sleep 2; break; \
      fi; \
    done; \
    while true; do \
      if [ -s "simple_inst.txt" ]; then \
        command=$(sed -n 1p simple_inst.txt); \
        sed -i 1d simple_inst.txt; \
        echo "$command"; \
        sleep 5; \
      fi; \
  done; )
pkill pppd
pkill l2tp
