#!/bin/bash

export MY_DISPLAY=:2

Xephyr -ac -br -noreset -screen 800x600 $MY_DISPLAY &
sleep 1
ulimit -c unlimited
DISPLAY=$MY_DISPLAY ./dwm
echo "return = $?"
