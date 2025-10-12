#!/usr/bin/env bash

STATE_FILE="/tmp/pomodoro_state"
DURATION=25  # minutes
BREAK=5      # minutes

start() {
  end=$(( $(date +%s) + DURATION * 60 ))
  echo "work $end" > "$STATE_FILE"
}

stop() {
  rm -f "$STATE_FILE"
  echo "Stopped"
}

status() {
  if [ ! -f "$STATE_FILE" ]; then
    echo "🍅 Idle"
    return
  fi
  read mode end < "$STATE_FILE"
  remaining=$(( end - $(date +%s) ))
  if (( remaining <= 0 )); then
    if [ "$mode" == "work" ]; then
      notify-send "Pomodoro complete" "Take a ${BREAK} min break!"
      echo "break $(( $(date +%s) + BREAK * 60 ))" > "$STATE_FILE"
      echo "☕ Break"
    else
      notify-send "Break over" "Back to work!"
      rm -f "$STATE_FILE"
      echo "🍅 Idle"
    fi
    return
  fi
  mins=$(( remaining / 60 ))
  secs=$(( remaining % 60 ))
  if [ "$mode" == "work" ]; then
    echo "🍅 $mins:$secs"
  else
    echo "☕ $mins:$secs"
  fi
}

case "$1" in
  click-left) start ;;
  click-right) stop ;;
  *) status ;;
esac

