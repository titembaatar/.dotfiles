#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

src_dir="$HOME/src/neovim"

if [ -d "$src_dir" ]; then
  log_info "neovim already installed."
  exit 0
fi

install ninja-build cmake gcc make gettext curl glibc-gconv-extra
mkdir -p "$src_dir"
git clone https://github.com/neovim/neovim "$src_dir"
cd "$src_dir"
git fetch origin
git checkout stable
git pull origin stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

