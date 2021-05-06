# Do not operate on floating windows!
[ -z "$(bspc query -N -n focused.floating)" ] || exit 1

dir=$1

if [ -n "$(bspc query -N -n "${dir}.local.!floating")" ]; then
	bspc node -s "$dir"
else
	bspc node @/ -p "$dir" -i
        receptacle="$(bspc query -N -n 'any.leaf.!window')"
        bspc node -n "$receptacle" --follow
fi
