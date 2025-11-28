#!/bin/bash
# Restart solaar to fix bluetooth mouse issues

killall solaar 2>/dev/null
sleep 0.5
solaar --window=hide &
notify-send "Solaar" "Restarted successfully" -t 2000
