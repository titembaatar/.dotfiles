#!/usr/bin/env bash

declare connected text class tooltip
get_tailscale_status() {
  connected=false
  text="󰦞"
  class="disconnected"
  tooltip="Not on the tailnet."

  local status_json
  if status_json=$(tailscale status --json 2>/dev/null); then
    local backend_state
    backend_state=$(echo "$status_json" | jq -r '.BackendState // "NoState"')
    tailnet_ip=$(echo "$status_json" | jq -r '.Self.TailscaleIPs[0]')

    if [[ "$backend_state" == "Running" ]]; then
      connected=true
      text=""
      class="connected"
      tooltip="Connected to the tailnet.\nIP: $tailnet_ip"
    fi
  fi
}

case "$1" in
  --status)
    get_tailscale_status

    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
    ;;
  --toggle)
    get_tailscale_status

    if $connected; then
      sudo tailscale down
    else
      sudo tailscale up
    fi
    ;;
  *)
    echo "usage: $0 {--status|--toggle}"
    exit 1
    ;;
esac
