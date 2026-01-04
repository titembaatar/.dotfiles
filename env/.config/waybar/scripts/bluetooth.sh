#!/usr/bin/env bash
set -e

mac="18:9C:2C:B2:FF:67"

if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$mac"
else
    bluetoothctl connect "$mac"
fi
