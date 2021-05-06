if [ $(bspc query -D -d focused --names) -eq 0 ]; then 
    current_node=$(bspc query -N -n)
    bspc node -s east
    bspc node -f $current_node
else
    bspc node -s east
fi
