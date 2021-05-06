#!/bin/bash

# bspwm doesn't do per-monitor monocle padding
# this is a hacky solution

# ~/.cache/monocle_desktop_n
#       contains 1 or 0 depending on if desktop is in monocle mode

desktops=$(bspc query -D --names)
for desktop in $desktops; do
    echo 0 > "$HOME/.cache/bspwm_monocle/desktop_$desktop"
done
