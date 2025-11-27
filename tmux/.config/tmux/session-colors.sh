#!/bin/bash
# Assigns a consistent color to each tmux session based on session name hash

SESSION_NAME="$1"

# Color palette - accent colors that work well with dark background
COLORS=(
    "67"   # steel blue (default)
    "168"  # pink/magenta
    "108"  # sage green
    "173"  # orange/rust
    "139"  # purple/lavender
    "73"   # teal/cyan
    "180"  # tan/gold
    "109"  # light blue
    "144"  # olive/yellow-green
    "167"  # coral/red
)

# Generate a hash from session name to pick a consistent color
hash_value=$(echo -n "$SESSION_NAME" | md5sum | cut -c1-8)
hash_decimal=$((16#$hash_value))
color_index=$((hash_decimal % ${#COLORS[@]}))
ACCENT="${COLORS[$color_index]}"

# Apply the color scheme
tmux set -t "$SESSION_NAME" status-left "#[fg=colour${ACCENT},bg=colour235,bold] #S #[fg=colour236,bg=colour235]"
tmux set -t "$SESSION_NAME" window-status-current-format "#[fg=colour235,bg=colour${ACCENT},bold] #I:#W #[fg=colour${ACCENT},bg=colour235,nobold]"
tmux set -t "$SESSION_NAME" status-right "#[fg=colour236]#[fg=colour252,bg=colour236] #H #[fg=colour${ACCENT},bg=colour236]#[fg=colour235,bg=colour${ACCENT},bold] %a %d %b %H:%M "
tmux set -t "$SESSION_NAME" pane-active-border-style "fg=colour${ACCENT}"
