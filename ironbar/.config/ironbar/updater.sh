#!/usr/bin/env bash

function bt {

    local connected_device=$(bluetoothctl devices Connected | head -n 1 | awk '{$1=""; $2=""; print}')
    local battery_icon="󰂂"
    local battery_pct="" 
    
    if [ ! -z "${connected_device}" ]; then
        battery_pct=$(printf "%d" $(bluetoothctl devices Connected | awk '{print $2}' | bluetoothctl info | awk '/Battery/{print $3}'))


        if (($battery_pct < 20)); then
            battery_icon="󰁺"
        elif (($battery_pct < 40)); then
            battery_icon="󰁼"
        elif (($battery_pct < 60)); then
            battery_icon="󰁾"
        elif (($battery_pct < 80)); then
            battery_icon="󰂀"
        fi

        ~/.cargo/bin/ironbar var set bluetooth "󰂰${connected_device} ${battery_icon} ${battery_pct}%"
    else
        if [ $(bluetoothctl show | awk '/PowerState/{print $2}') == 'on' ]; then
            ~/.cargo/bin/ironbar var set bluetooth "󰂯 On"
        else
            ~/.cargo/bin/ironbar var set bluetooth "󰂲 Off"
        fi
    fi

}

function network {
    local network=$(nmcli -t -f NAME c s | head -n 1)
    if [ ! -z "${network}" ]; then 
        ~/.cargo/bin/ironbar var set network "󰖩 ${network}"
    else
        ~/.cargon/bin/ironbar var set network "󰖪 Off"
    fi
}

function main {
    bt
    network
}

main
exit 0
