#!/usr/bin/env bash
set -e

src_dir="$HOME/src/neovim"

sudo dnf install -y ninja-build cmake gcc make gettext curl glibc-gconv-extra
sudo dnf mark dependency ninja-build cmake gcc make gettext curl glibc-gconv-extra

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

