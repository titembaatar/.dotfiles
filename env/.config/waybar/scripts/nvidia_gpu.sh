#!/usr/bin/env bash

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
class=""

if ((usage >= 85)); then
	class="critical"
elif ((usage >= 70)); then
	class="warning"
fi

printf '{"text": "%s", "class": "%s"}' \
	"$usage" "$class"
