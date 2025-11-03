#!/bin/bash

# This script reads projects.conf and creates tmux sessions/windows for each project.
CONFIG_FILE="$(dirname "$0")/projects.conf"

if [ ! -f "$CONFIG_FILE" ]; then
	echo "Config file $CONFIG_FILE not found!"
	exit 1
fi

current_project=""
project_dir=""
declare -A windows
declare -A dirs
projects=()

while IFS= read -r line || [ -n "$line" ]; do
	line="${line%%#*}" # Remove comments
	line="${line%%$'\r'}" # Remove CR if present
	line="${line##*( )}" # Trim leading spaces
	line="${line%%*( )}" # Trim trailing spaces
	[ -z "$line" ] && continue

	if [[ $line =~ ^\[(.*)\]$ ]]; then
		current_project="${BASH_REMATCH[1]}"
		projects+=("$current_project")
		windows["$current_project"]=""
		dirs["$current_project"]=""
	elif [[ $line == dir=* ]]; then
		dirs["$current_project"]="${line#dir=}"
	elif [[ $line == window=* ]]; then
		win="${line#window=}"
		if [ -z "${windows[$current_project]}" ]; then
			windows["$current_project"]="$win"
		else
			windows["$current_project"]+=$'\n'$win
		fi
	fi
done < "$CONFIG_FILE"

# Create tmux sessions and windows
first_session=""

for project in "${projects[@]}"; do
	session="$project"
	dir="${dirs[$project]}"
	dir_expanded=$(eval echo "$dir")
	IFS=$'\n' read -rd '' -a winlist <<< "${windows[$project]}"
	if [ -z "$first_session" ]; then
		first_session="$session"
	fi
	for i in "${!winlist[@]}"; do
		win_line="${winlist[$i]}"
		# Parse window line: name[:relpath[:command]]
		IFS=':' read -r win_name rel_path win_cmd <<< "$win_line"
		# If rel_path is empty, use project dir
		if [ -n "$rel_path" ]; then
			win_dir="$dir_expanded/$rel_path"
		else
			win_dir="$dir_expanded"
		fi
		# Expand $HOME in win_dir
		win_dir=$(eval echo "$win_dir")
		if [ "$i" -eq 0 ]; then
			tmux new-session -d -s "$session" -n "$win_name" -c "$win_dir"
			[ -n "$win_cmd" ] && tmux send-keys -t "$session:0" "$win_cmd" C-m
		else
			tmux new-window -t "$session:" -n "$win_name" -c "$win_dir"
			[ -n "$win_cmd" ] && tmux send-keys -t "$session:$win_name" "$win_cmd" C-m
		fi
	done
done

# Attach to the first session
if [ -n "$first_session" ]; then
	tmux attach-session -t "$first_session"
else
	echo "No projects defined in $CONFIG_FILE."
fi
