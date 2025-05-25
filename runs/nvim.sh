#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

src_dir="$HOME/src/neovim"

install ninja-build cmake gcc make gettext curl glibc-gconv-extra

if [ ! -d "$src_dir" ]; then
  mkdir -p "$src_dir"
fi

git clone https://github.com/neovim/neovim "$src_dir"
cd "$src_dir"
git fetch origin
git checkout stable
git pull origin stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

