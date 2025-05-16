#!/usr/bin/env bash
set -e

sudo dnf install -y tmux
sudo dnf mark user tmux
git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/env/.config/tmux/plugins/tpm
