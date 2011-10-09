#!/bin/bash

export MY_DISPLAY=:2
usage() {
    echo "Usage: $0 [-d|s|v]"
    echo " -d Run in gdb"
    echo " -s Run using dwm-start script"
    echo " -v Run in valgrind"
}

command=./dwm
while getopts dsv opt ; do
    case "$opt" in
        d) command="gdb ./dwm"
            ;;
        s) command=./scripts/dwm-start.sh 
            ;;
        v) command="valgrind ./dwm"
            ;;
        \?)
            #echo "Invalid option: -$OPTARG"
            usage
            exit 1
            ;;
    esac
done

#Start windowed X11 instance
Xephyr -ac -br -noreset -screen 800x600 $MY_DISPLAY &
sleep 1
ulimit -c unlimited

# and run dwm
DISPLAY=$MY_DISPLAY $command
echo "return = $?"
