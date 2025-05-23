#!/bin/sh

MONITOR_COUNT=$(xrandr --listactivemonitors | grep -c "^ ")

if [ "$MONITOR_COUNT" -eq 2 ]; then
  # Two monitors connected: turn OFF laptop screen
  xrandr --output eDP-1 --off && xrandr --output DP-1 --mode 1900x1200 --rate 100
elif [ "$MONITOR_COUNT" -eq 1 ]; then
  # Only one monitor (likely unplugged from DP-1): turn ON laptop screen
  xrandr --auto
fi

xset -dpms
xset s off
xset s noblank
xset s noexpose
