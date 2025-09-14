#!/bin/bash

# Toggle Bluetooth active profiles function when executed shall switch between a2dp_sink and headset-head-unit-msbc
CARD="bluez_card.98_47_44_15_E9_F4"
CURRENT_PROFILE=$(pactl list cards | grep -A 20 "$CARD" | grep "Active Profile:" | awk -F':' '{print $2}' | xargs)

case "$CURRENT_PROFILE" in
  "a2dp-sink")
    pactl set-card-profile "$CARD" headset-head-unit-msbc
    notify-send "Bluetooth Profile" "Switched to Headset Head Unit (mSBC)"
    ;;
  "headset-head-unit-msbc")
    pactl set-card-profile "$CARD" a2dp-sink
    notify-send "Bluetooth Profile" "Switched to A2DP Sink"
    ;;
  *)
    notify-send "Bluetooth Profile" "Current profile is neither a2dp-sink nor headset-head-unit-msbc"
    ;;
esac