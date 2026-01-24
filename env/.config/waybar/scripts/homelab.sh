#!/usr/bin/env bash

nodes=(
	# ip:name
	"10.0.0.10:nas"
	"10.0.0.11:worker1"
	"10.0.0.12:worker2"
	"10.0.0.13:worker3"
	"10.0.0.19:backup"
)

timeout=2
healthy=true
tooltip=""

for node in "${nodes[@]}"; do
	name=${node#*:}
	ip=${node%:*}
	status="up"

	if ! ping -c 1 -W "$timeout" "$ip" &>/dev/null; then
		status="down"
		healthy=false
	fi

	tooltip+="$name\t| $ip | $status"

	if [[ $node != "${nodes[-1]}" ]]; then
		tooltip+="\n"
	fi
done

text="up"
class="up"
if [[ $healthy = false ]]; then
	text="down"
	class="down"
fi

printf '{"text": "%s", "class": "%s", "tooltip": "%s"}' \
	"$text" "$class" "$tooltip"
