#!/bin/bash

# Detect monitors
MONITORS=$(xrandr --query | grep " connected")

# Refresh settings
xset s noblank
xset s noexpose
xset s off
xset -dpms

if echo "$MONITORS" | grep -q "DP-1-8 connected" && echo "$MONITORS" | grep -q "DP-1-9 connected"; then
    # Multi-monitor setup
    xrandr --output eDP-1 --mode 1920x1200 --rate 60 --pos 3840x0 --rotate normal \
           --output DP-1-8 --primary --mode 1920x1080 --rate 75 --pos 1920x0 --rotate normal \
           --output DP-1-9 --mode 1920x1200 --rate 60 --pos 0x0 --rotate normal
else
    # Single external monitor (DP-1)
    xrandr --output eDP-1 --auto --primary
fi

