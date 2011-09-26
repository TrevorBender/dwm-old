#!/bin/sh

MEM_TOTAL=$(free -m | grep Mem: | awk '{print $2}')

function mem_free ()
{
    local mem_free=$(free -m | grep cache: | awk '{print $4}')
    echo "$mem_free/${MEM_TOTAL}MB"
}

function show_status ()
{
    local mpd_string=$(mpdstatus.sh)
    local uptime_string=$(uptime | sed  's/.*://; s/,//g')
    local date_string=$(date +"%a %b %d %R")
    local mem_info=$(mem_free)
    xsetroot -name "[$mpd_string] [$mem_info$uptime_string] [$date_string]";
}

# status line
while true ; do
    mpc -q idle player
    show_status
done &
MPD_STATUS_PID=$?

while true ; do 
    show_status
    sleep 5; 
done &
STATUS_PID=$?

xsetroot -solid "#1b1d1e"
#feh --bg-scale /opt/backup/storage/backup/desktop\ pics/nature.jpg

# start dwm
while true ; do
    MSG="DWM START $(date)"
    echo "$MSG" >> ~/.cache/dwm/stdout 
    echo "$MSG" >> ~/.cache/dwm/stderr 
    # if dwm exits with 0 the loop continues,
    # otherwise break and exit
    dwm >> ~/.cache/dwm/stdout 2>> ~/.cache/dwm/stderr || break
done

kill -9 ${STATUS_PID}
kill -9 ${MPD_STATUS_PID}
