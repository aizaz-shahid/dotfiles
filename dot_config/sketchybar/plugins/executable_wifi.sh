source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

WIFI_NAME=$(networksetup -getairportnetwork en0 | awk '{ print $4 }')
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
	COLOR=$COLOR_CYAN
	ICON=$ICON_VPN
	LABEL="VPN"
elif [[ $WIFI_NAME != "" ]]; then
	COLOR=0xff58d1fc
	ICON=$ICON_WIFI
	LABEL=$WIFI_NAME
else
	COLOR=$COLOR_WHITE
	ICON=$ICON_WIFI_OFF
	LABEL="Not Connected"
fi

sketchybar --set $NAME icon.color=$COLOR \
	icon=$ICON \
	label="$LABEL"

