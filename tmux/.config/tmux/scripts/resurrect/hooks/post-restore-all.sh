#!/bin/bash

function ssh_reconnect_windows() {
	if ! tmux has-session -t ssh 2>/dev/null; then
		return
	fi

	windows=$(tmux list-windows -t ssh -F "#{window_name}")
	for window in $windows; do
		panes=$(tmux list-panes -t ssh:"$window" -F "#{pane_index}")
		for pane in $panes; do
			tmux send-keys -t ssh:"$window"."$pane" "ssh $window" C-m

			if [ "$window" == "chingis" ] || [ "$window" == "zev" ]; then
				tmux send-keys -t ssh:"$window"."$pane" "cd ~" C-m
				tmux send-keys -t ssh:"$window"."$pane" "clear" C-m
			elif [ "$window" == "proxy" ]; then
				tmux send-keys -t ssh:"$window"."$pane" "cd /config/homelab/compose/caddy" C-m
				tmux send-keys -t ssh:"$window"."$pane" "clear" C-m
			elif [ "$window" == "servarr" ] || [ "$window" == "docker" ]; then
				tmux send-keys -t ssh:"$window"."$pane" "cd /config/homelab/compose" C-m
				tmux send-keys -t ssh:"$window"."$pane" "clear" C-m

				if [ "$pane" == 2 ]; then
					tmux resize-pane -t ssh:"$window"."$pane" -x 30%
					tmux send-keys -t ssh:"$window"."$pane" "lzd" C-m
				fi
			fi

		done
	done
}

function main () {
	ssh_reconnect_windows 
}

main
