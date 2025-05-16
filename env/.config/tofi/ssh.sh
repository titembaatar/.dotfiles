#!/bin/bash
set -e

TOFI_CONFIG=$HOME/.config/tofi/config

ssh_list=$(grep '^Host ' "$HOME"/.ssh/config | awk '{print $2}')
selected=$(echo "$ssh_list" | tofi --config "$TOFI_CONFIG")
tmux new-session -ds "$selected" -n ssh ssh "$selected"; tmux switch-client -t "$selected"
swaymsg workspace 1
