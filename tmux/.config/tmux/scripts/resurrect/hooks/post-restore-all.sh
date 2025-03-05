#!/bin/bash

function ssh_reconnect_windows() {
	if ! tmux has-session -t ssh 2>/dev/null; then
		return
	fi

	windows=$(tmux list-windows -t ssh -F "#{window_name}")
	for window in $windows; do
		local script="$HOME/.config/tmux/scripts/ssh-connect/$window.sh"
		if [[ -f "$script" ]]; then
			tmux send-keys -t ssh:"$window" "$script" C-m
		fi
	done
}

function main () {
	ssh_reconnect_windows 
}

main
