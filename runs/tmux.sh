#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

install tmux

git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/env/.config/tmux/plugins/tpm
