#!/bin/sh
# Print an mpd status

result=$(mpc)
if [[ $(echo "$result" | wc -l) -eq 3 ]] ; then
    song_name=$(echo "$result" | head -1 | head -c 30)
    play_string=$(echo "$result" | head -2 | tail -1 | awk '{print $1}')
    case "$play_string" in
        \[playing\])
            play_status="|>"
            ;;
        \[paused\])
            play_status="||"
            ;;
        *)
            play_status="[]"
            ;;
    esac
else
    song_name=""
    play_status="[]"
fi

echo "$play_status $song_name"
