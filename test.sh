#!/bin/bash

export MY_DISPLAY=:2

Xephyr -ac -br -noreset -screen 800x600 $MY_DISPLAY &
sleep 1
ulimit -c unlimited
if [[ $# -gt 0 ]] ;  then
    if [[ $1 = "-d" ]] ; then
        DISPLAY=$MY_DISPLAY gdb ./dwm
        exit 0
    elif [[ $1 = "-l" ]] ; then
        DISPLAY=$MY_DISPLAY ./dwm
        exit 0
    fi
fi
DISPLAY=$MY_DISPLAY ./scripts/dwm-start.sh
echo "return = $?"
