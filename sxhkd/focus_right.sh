if [ $(bspc query -D -d focused --names) -eq 0 ]; then 
    bspc node -f east || bspc desktop -f $(bspc query -D -d last --names)
else
    bspc node -f east
fi
