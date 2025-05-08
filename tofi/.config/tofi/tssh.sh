#!/bin/bash
set -e

TERM=$(grep 'set $term' "$HOME"/.config/sway/config | awk '{print $3}')
TOFI_CONFIG=$HOME/.config/tofi/config

ssh_list=$(grep '^Host ' "$HOME"/.ssh/config | awk '{print $2}')
selected=$(echo "$ssh_list" | tofi --config "$TOFI_CONFIG")
$TERM -e ssh "$selected"
