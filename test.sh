#!/bin/bash

scriptdir=$(dirname $0)

export MY_DISPLAY=:2
usage() {
    echo "Usage: $0 [-d|s|v]"
    echo " -d Run in gdb"
    echo " -s Run using dwm-start script"
    echo " -v Run in valgrind"
}

command=$scriptdir/dwm
while getopts dsv opt ; do
    case "$opt" in
        d) command="gdb $command"
            ;;
        s) command=$scriptdir/scripts/dwm-start.sh 
            ;;
        v) command="valgrind $command"
            ;;
        \?)
            #echo "Invalid option: -$OPTARG"
            usage
            exit 1
            ;;
    esac
done

echo "command=$command"

#Start windowed X11 instance
Xephyr -ac -br -noreset -screen 800x600 $MY_DISPLAY &
sleep 1
ulimit -c unlimited
DISPLAY=$MY_DISPLAY xrdb -merge ~/.Xresources
DISPLAY=$MY_DISPLAY xsetroot -solid "#fdf6e3"

# and run dwm
DISPLAY=$MY_DISPLAY $command
echo "return = $?"
