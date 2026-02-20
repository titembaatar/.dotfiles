#!/usr/bin/env bash

nodes=(
	# ip:name
	"10.0.0.10:nas"
	"10.0.0.11:worker1"
	"10.0.0.12:worker2"
	"10.0.0.13:worker3"
	"10.0.0.19:backup"
)

declare class="on" tooltip
for node in "${nodes[@]}"; do
	ip=${node%:*}
	ping -c 1 -W 2 "$ip" &>/dev/null || class="off"
	tooltip+="${node#*:}\t| $ip | $class"
	[[ $node == "${nodes[-1]}" ]] || tooltip+="\n"
done

printf '{"class": "%s", "tooltip": "%s"}' \
	"$class" "$tooltip"
