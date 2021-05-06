desktop=$(bspc query -D -d --names)
layout=$(bspc query -T -d | jq -r .layout)

if [[ "$layout" == "tiled" ]]; then
    tiled_nodes=$(bspc query -N -n .local.tiled.leaf)
    first=1
    for node in $tiled_nodes; do
        if [[ "$first" == "1" ]]; then
            xprop -id "$node" -remove _COMPTON_NO_SHADOW
            first=0
        else
            xprop -id "$node" -f _COMPTON_NO_SHADOW 32c -set _COMPTON_NO_SHADOW 1
        fi
    done
    read -r pt pb pl pr _ _ _ _ < "$HOME/.config/bspwm/monocle/config_desktop_$desktop"
else
    tiled_nodes=$(bspc query -N -n '.local.tiled.leaf')
    for node in $tiled_nodes; do
        xprop -id "$node" -f _COMPTON_NO_SHADOW 32c -set _COMPTON_NO_SHADOW 1
    done
    read -r _ _ _ _ pt pb pl pr < "$HOME/.config/bspwm/monocle/config_desktop_$desktop"
fi

bspc config -d $desktop top_padding $pt & bspc config -d $desktop bottom_padding $pb & bspc config -d $desktop left_padding $pl & bspc config -d $desktop right_padding $pr & bspc desktop -l next
