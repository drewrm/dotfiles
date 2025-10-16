#!/usr/bin/env bash

function restart() {
    pkill waybar 2>/dev/null || true
    nohup waybar >/dev/null 2>&1 &
    notify-send -u low -t 2500 "Waybar restarted"
}

main() {
    case "$1" in
	*)
	    restart
	    ;;
		
    esac
}


main $@
