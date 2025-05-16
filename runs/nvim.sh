#!/usr/bin/env bash
set -e

SRC="$HOME/src/neovim"

sudo dnf install -y ninja-build cmake gcc make gettext curl glibc-gconv-extra
sudo dnf mark dependency ninja-build cmake gcc make gettext curl glibc-gconv-extra

if [ ! -d "$SRC" ]; then
  git clone https://github.com/neovim/neovim "$SRC"
fi

cd "$SRC"
git fetch origin
git checkout stable
git pull origin stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

