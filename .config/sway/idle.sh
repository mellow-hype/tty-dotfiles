#!/usr/bin/env bash
# exec swayidle -w \
#          timeout 300 'swaylock -f -c 000000' \
#          timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
#          before-sleep 'swaylock -f -c 000000'

let LOCK_TIMEOUT=600
let DPMS_TIMEOUT=900

IDLE=~/.config/sway/

LOCKCMD="swaylock -f -c 3f4944"
DPMS_ON='swaymsg "output * dpms on"'
DPMS_OFF='swaymsg "output * dpms off"'

swayidle \
    timeout "$LOCK_TIMEOUT"   "$IDLE/media-playing.sh && $LOCKCMD" \
    timeout "$DPMS_TIMEOUT"   "$IDLE/media-playing.sh && $DPMS_OFF" resume  "$DPMS_ON" \
    before-sleep "$LOCKCMD"
