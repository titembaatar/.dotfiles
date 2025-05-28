#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

src_dir="$HOME/src/keyd"

if [ ! -d $src_dir ];then
  mkdir -p $src_dir
  git clone https://github.com/rvaiya/keyd $src_dir
  cd $src_dir
  make && sudo make install
else
  log_info "keyd already installed. Skipping."
fi

sudo ln -fs $HOME/.dotfiles/env/.config/keyd/default.conf /etc/keyd/
sudo systemctl enable --now keyd

