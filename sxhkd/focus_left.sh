if [ $(bspc query -D -d focused --names) -ne 0 ]; then 
    bspc node -f west || bspc desktop -f 0
else
    bspc node -f west
fi
