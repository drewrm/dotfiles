#!/usr/bin/env bash

HEADPHONES="80:4A:F2:00:FF:A6"

function main() { 
    case "$1" in
        devices)
            bluetoothctl devices
            ;;
        status)
            bluetoothctl info
            ;;
        connect)
            bluetoothctl connect ${HEADPHONES}
            ;;
        disconnect)
            bluetoothctl disconnect ${HEADPHONES}
            ;;
        *)
            if [[ "$(bluetoothctl devices Connected)" =~ "${HEADPHONES}" ]]; then
                bluetoothctl disconnect ${HEADPHONES}
            else
                bluetoothctl connect ${HEADPHONES}
            fi
            ;;
    esac
}

main $@

