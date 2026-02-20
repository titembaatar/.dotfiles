#!/usr/bin/env bash

declare text="Disconnected" class="off" tooltip="Disconnected from the tailnet."

status=$(tailscale status --json 2>/dev/null)
[[ $status ]] || exit 1
if [[ $(jq -r '.BackendState' <<< "$status") == 'Running' ]]; then
	text="Connected"
	class="on"
	ip=$(jq -r '.Self.TailscaleIPs[0]' <<< "$status")
 	tooltip="Connected to the tailnet.\nIP: $ip"
fi


case "$1" in
	--status)
		printf '{"text": "%s", "alt": "%s", "class": "%s", "tooltip": "%s"}' \
			"$text" "$class" "$class" "$tooltip"
		;;
	--toggle)
		if [[ $class == "off" ]]; then
			sudo tailscale up
			exit 0
		fi

		sudo tailscale down
		;;
esac
