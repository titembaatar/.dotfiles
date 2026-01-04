#!/usr/bin/env bash
set -e

running=$(pactl list short sinks | grep RUNNING | awk '{print $2}')
headphones="alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink"
speakers="alsa_output.usb-Generic_USB_Audio-00.HiFi__SPDIF__sink"
bluetooth="bluez_output.18_9C_2C_B2_FF_67.1"

mac="18:9C:2C:B2:FF:67"

if [ $running = $speakers ] && bluetoothctl info "$mac" | grep -q "Connected: yes"; then
  pactl set-default-sink $bluetooth
elif [ $running = $speakers ]; then
  pactl set-default-sink $headphones
else
  pactl set-default-sink $speakers
fi
