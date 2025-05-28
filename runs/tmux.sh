#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

install tmux

tpm_dir="$HOME/.dotfiles/env/.config/tmux/plugins/tpm"
if [ ! -d $tpm_dir ]; then
  git clone https://github.com/tmux-plugins/tpm $tpm_dir
fi
