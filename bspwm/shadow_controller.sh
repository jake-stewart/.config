#!/bin/bash

# hooks onto events when windows are added/removed/made floating
# goal is to only make floating and monocled windows have shadows

bspc subscribe node_add | while read -r _ _ desktop _ node; do
    state=$(bspc query -T -n "$node" | jq -r .client.state) 
    if [[ "$state" == "tiled" ]]; then
        desktop=$(bspc query -D -d $desktop --names)
        layout=$(bspc query -T -d | jq -r .layout)
        if [[ "$layout" == "monocle" ]]; then
            n_nodes=$(bspc query -d $desktop -N -n .tiled.leaf | wc -l)
            if [[ "$n_nodes" -gt "1" ]]; then
                xprop -id "$node" -f _COMPTON_NO_SHADOW 32c -set _COMPTON_NO_SHADOW 1
            fi
        else
            xprop -id "$node" -f _COMPTON_NO_SHADOW 32c -set _COMPTON_NO_SHADOW 1
        fi
    fi
done &

bspc subscribe node_remove | while read -r _ _ desktop node; do
    desktop=$(bspc query -D -d $desktop --names)
        layout=$(bspc query -T -d | jq -r .layout)
        if [[ "$layout" == "monocle" ]]; then
        desktop_nodes=$(bspc query -d $desktop -N -n .tiled.leaf)
        first=1
        for node in $desktop_nodes; do
            if [[ "$first" == "1" ]]; then
                xprop -id "$node" -remove _COMPTON_NO_SHADOW
                first=0
            else
                xprop -id "$node" -f _COMPTON_NO_SHADOW 32c -set _COMPTON_NO_SHADOW 1
            fi
        done
    fi
done &

bspc subscribe node_state | while read -r _ _ _ node state status; do
    if [[ "$state" == "floating" ]]; then
        case "$status" in
            on) xprop -id "$node" -remove _COMPTON_NO_SHADOW;;
            off) xprop -id "$node" -f _COMPTON_NO_SHADOW 32c -set _COMPTON_NO_SHADOW 1;;
        esac
    fi
done &
