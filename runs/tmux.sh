#!/usr/bin/env bash
set -e

sudo dnf install mark tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/env/.config/tmux/plugins/tpm
