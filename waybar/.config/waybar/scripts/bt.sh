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
        *)
            for device in "${HEADPHONES}"; do
                if [[ "$(bluetoothctl devices Connected)" =~ "${device}" ]]; then
                    bluetoothctl disconnect ${device}
                else
                    bluetoothctl connect ${device}
                fi
            done

           
            ;;
    esac
}

main $@

