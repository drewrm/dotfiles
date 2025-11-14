#!/usr/bin/env bash

function main() {
    local command=$1
    local result=0
    local window_id=""

    case "${XDG_SESSION_DESKTOP}" in 
        Hyprland)
            result = $(hyprctl clients | grep "class: ${command}")
            ;;
        niri)
            window_id=$(niri msg windows | grep -B2 "App ID: \"${command}" | grep -Po '\d+')
            result=$?
            ;;
        *)
            ;;
    esac

    if [ $result -ne 0 ]; then
        contour class ${command} ${command}
    else 
        case "${XDG_SESSION_DESKTOP}" in 
            Hyprland)
                hyprctl dispatch focuswindow class:${command}
                ;;
            niri)
                niri msg action focus-window --id ${window_id}
                ;;
            *)
                notify-send "Unknown Desktop" "This is not supported"
        esac
    fi
}

main $@
