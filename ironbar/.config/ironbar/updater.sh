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
        ~/.cargo/bin/ironbar var set network "󰖪 Off"
    fi
}

function sound {
    local volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
    local volume_display="${volume}%"

    if (($volume < 1)); then
        volume_icon="󰝟"
    elif (($volume < 30)); then
        volume_icon="󰕿"
    elif (($volume < 60)); then
        volume_icon="󰖀"
    else
        volume_icon="󰕾"
    fi

    if [ ! -z "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')" ]; then
        volume_icon="󰝟"
        volume_display="${volume_display} (muted)"
    fi

    if [ ! -z "${volume_display}" ]; then
        ~/.cargo/bin/ironbar var set sound "${volume_icon} ${volume_display}"
    else
        ~/.cargo/bin/ironbar var set sound "󰖁 Off"
    fi

}

function cleanup {
    exit 0
}

function main {
    while true; do
        bt
        network
        sound
        sleep 2
    done
}

trap cleanup SIGTERM SIGINT

main
