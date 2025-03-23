#!/bin/bash
# Script to send time notification every hour
CURRENT_TIME=$(date "+%I:%M %p")
notify-send "Time Reminder" "Current Time: $CURRENT_TIME"
