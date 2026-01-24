#!/usr/bin/env bash

mac="18:9C:2C:B2:FF:67"

if bluetoothctl devices Connected; then
	bluetoothctl disconnect "$mac"
	exit 0
fi

bluetoothctl connect "$mac"
