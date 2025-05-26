#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

src_keyd="$HOME/src/keyd"

if [ ! -d "$src_keyd" ];then
  mkdir -p "$src_keyd"
  git clone https://github.com/rvaiya/keyd "$src_keyd"
  cd "$src_keyd"
  make && sudo make install
else
  log_info "keyd already installed. Skipping."
fi

sudo ln -fs "$HOME"/.dotfiles/env/.config/keyd/default.conf /etc/keyd/
sudo systemctl enable --now keyd

