if [ $(bspc query -D -d focused --names) -ne 0 ]; then 
    bspc node -s west
    bspc node -f last
else
    bspc node -s west
fi
