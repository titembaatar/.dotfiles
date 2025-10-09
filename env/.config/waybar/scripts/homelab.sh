#!/bin/bash

NODES=("10.0.0.10" "10.0.0.11" "10.0.0.12" "10.0.0.13" "10.0.0.19")
NODE_NAMES=("NAS" "worker1" "worker2" "worker3" "backup")
TIMEOUT=2
HEALTHY=true
TOOLTIP=""

for i in "${!NODES[@]}"; do
  TOOLTIP+="${NODE_NAMES[$i]}: "

  if ping -c 1 -W $TIMEOUT "${NODES[$i]}" > /dev/null 2>&1; then
    TOOLTIP+="up"
  else
    TOOLTIP+="down"
    HEALTHY=false
  fi

  if [ "$i" -lt $((${#NODES[@]} - 1)) ]; then
    TOOLTIP+="\n"
  fi
done

if $HEALTHY; then
  TEXT="up"
  CLASS="up"
else
  TEXT="down"
  CLASS="down"
fi

echo "{\"text\": \"$TEXT\", \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
