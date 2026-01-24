#!/usr/bin/env bash

connected=false
text="󰦞"
class="disconnected"
tooltip="Not on the tailnet."

get_tailscale_status() {
	local status

	if ! status=$(tailscale status --json 2>/dev/null); then
		return 1
	fi

	local data tailnet_ip
	data=$(jq -r '.BackendState + "\t" + .Self.TailscaleIPs[0]' \
		<<< "$status")

	local backend_state="${data%$'\t'*}"
	local tailnet_ip="${data#*$'\t'}"

	if [[ "$backend_state" == "Running" ]]; then
		connected=true
		text=""
		class="connected"
		tooltip="Connected to the tailnet.\nIP: $tailnet_ip"
	fi
}

case "$1" in
--status)
	get_tailscale_status

	printf '{"text": "%s", "tooltip": "%s", "class": "%s"}' \
		"$text" "$tooltip" "$class"
	;;
--toggle)
	get_tailscale_status

	if $connected; then
		sudo tailscale down
		exit 0
	fi

	sudo tailscale up
	;;
*)
	echo "usage: $0 {--status|--toggle}"
	exit 1
	;;
esac
