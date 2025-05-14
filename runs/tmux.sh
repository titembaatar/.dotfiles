#!/usr/bin/env bash
set -e

sudo dnf mark install -y tmux
git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/env/.config/tmux/plugins/tpm
