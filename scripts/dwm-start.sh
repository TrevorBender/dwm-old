#!/bin/sh

# status line
while true ; do 
    xsetroot -name "$(uptime | sed 's/.*://; s/,//g') - $(date +"%a %b %d %R")";
    sleep 5; 
done &
STATUS_PID=$?

# start dwm
while true ; do
    MSG="DWM START $(date)"
    echo "$MSG" >> ~/.cache/dwm/stdout 
    echo "$MSG" >> ~/.cache/dwm/stderr 
    # if dwm exits with 0 the loop continues,
    # otherwise break and exit
    dwm >> ~/.cache/dwm/stdout 2>> ~/.cache/dwm/stderr || break
done

kill -2 ${STATUS_PID}
