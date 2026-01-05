#!/usr/bin/env bash

declare -A nodes=(
  [nas]="10.0.0.10"
  [worker1]="10.0.0.11"
  [worker2]="10.0.0.12"
  [worker3]="10.0.0.13"
  [backup]="10.0.0.19"
)

timeout=2
healthy=true
tooltip=""

readarray -t keys < <(printf "%s\n" "${!nodes[@]}" | sort -V)

for ((idx=0; idx<${#keys[@]}; idx++)); do
  i="${keys[$idx]}"
  tooltip+="$i: "

  if ping -c 1 -W "$timeout" "${nodes[$i]}" >/dev/null 2>&1; then
    tooltip+="up"
  else
    tooltip+="down"
    healthy=false
  fi

  if [[ $idx -lt $((${#keys[@]} - 1)) ]]; then
    tooltip+="\n"
  fi
done

declare text class
if $healthy; then
  text="up"
  class="up"
else
  text="down"
  class="down"
fi

echo "{\"text\": \"$text\", \"class\": \"$class\", \"tooltip\": \"$tooltip\"}"
