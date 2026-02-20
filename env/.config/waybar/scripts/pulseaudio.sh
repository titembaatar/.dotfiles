#!/usr/bin/env bash

running=$(pactl get-default-sink)
is_bluetooth=$(bluetoothctl devices Connected)
if [[ -n $is_bluetooth ]]; then
	bt_mac=${is_bluetooth#* }
	bt_sink="bluez_output.${bt_mac%% *}"
fi

headphones="alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink"
speakers="alsa_output.usb-Generic_USB_Audio-00.HiFi__SPDIF__sink"
ear_device=${bt_sink:-$headphones}
if [[ ${running,,} == "${speakers,,}" ]]; then
	pactl set-default-sink "$ear_device"
	exit 0
fi

pactl set-default-sink "$speakers"
