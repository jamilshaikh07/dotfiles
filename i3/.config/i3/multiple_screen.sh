#!/bin/bash

# Function to count connected displays
count_connected_displays() {
    xrandr --query | grep -c " connected"
}

# Function to set multi-monitor layout
set_multi_monitor() {
    # Check if both external monitors are connected
    if xrandr | grep -q "DP-1-8 connected" && xrandr | grep -q "DP-1-9 connected"; then
        xrandr --output eDP-1 --mode 1920x1200 --rate 60 --pos 3840x0 --rotate normal \
               --output DP-1-8 --primary --mode 1920x1080 --rate 75 --pos 1920x0 --rotate normal \
               --output DP-1-9 --mode 1920x1200 --rate 60 --pos 0x0 --rotate normal 
    else
        # If external monitors aren't connected, reset to auto
        xrandr --auto
    fi
}

# Main script
connected_displays=$(count_connected_displays)

if [ "$connected_displays" -gt 1 ]; then
    set_multi_monitor
else
    xrandr --auto
fi

xset s noblank
xset s off
xset -dpms

