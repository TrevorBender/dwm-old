#!/bin/sh

# status line
while try ; do
    mpc idle player
    mpd_string=$(mpdstatus.sh)
    uptime_string=$(uptime | sed  's/.*://; s/,//g')
    date_string=$(date +"%a %b %d %R")
    xsetroot -name "M{$mpd_string} L{$uptime_string} D{$date_string}";
done &
MPD_STATUS_PID=$?

while true ; do 
    mpd_string=$(mpdstatus.sh)
    uptime_string=$(uptime | sed  's/.*://; s/,//g')
    date_string=$(date +"%a %b %d %R")
    xsetroot -name "M{$mpd_string} L{$uptime_string} D{$date_string}";
    sleep 5; 
done &
STATUS_PID=$?

feh --bg-scale /opt/backup/storage/backup/desktop\ pics/nature.jpg

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
