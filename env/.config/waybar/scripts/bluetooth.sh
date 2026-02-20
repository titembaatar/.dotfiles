#!/usr/bin/env bash

MAC="18:9C:2C:B2:FF:67"

connect() {
	if [[ $(bluetoothctl devices Connected) ]]; then
		bluetoothctl disconnect "$MAC"
		exit 0
	fi

	bluetoothctl connect "$MAC"
}

toggle() {
	power=$(bluetoothctl show | grep "Powered: yes")
	if [[ $power ]]; then
		bluetoothctl power off
		exit 0
	fi

	bluetoothctl power on
}

case "$1" in
	--connect) connect ;;
	--toggle) toggle ;;
esac
