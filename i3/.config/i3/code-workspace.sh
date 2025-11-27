#!/bin/bash
# Assign VS Code to workspace based on working directory

# Get the focused window's working directory
# Wait a moment for the window to fully spawn
sleep 0.3

# Get the PID of the newest code process
PID=$(pgrep -n -f "code")

if [ -z "$PID" ]; then
    exit 0
fi

# Get the current working directory of the process
CWD=$(readlink -f /proc/$PID/cwd 2>/dev/null)

# Determine workspace based on directory
case "$CWD" in
    *workspace/acquia*)
        WS=3
        ;;
    *workspace/homelab*)
        WS=5
        ;;
    *)
        WS=4
        ;;
esac

# Move the window to the appropriate workspace
i3-msg "[class=\"(?i)code\"] move to workspace number $WS"
