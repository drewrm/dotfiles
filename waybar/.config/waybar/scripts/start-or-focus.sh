#!/usr/bin/env bash

function main() {
    command=$1
    
    hyprctl clients | grep "class: ${command}"

    if [ $? -ne 0 ]; then
        if [[ "${command}" == "btop" ]]; then 
            # btop works better in alacritty
            alacritty --title ${command} --class ${command} -e ${command}
        else
            contour class ${command} ${command}
        fi
    else 
        hyprctl dispatch focuswindow class:${command}
    fi
}

main $@
