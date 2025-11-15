#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

install ddcutil
sudo modprobe i2c-dev
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c-dev.conf
sudo modprobe ddcci
sudo ddcutil detect
