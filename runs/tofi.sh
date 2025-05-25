#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

SRC="$HOME/src/tofi"

install meson scdoc wayland-protocols-devel freetype-devel cairo-devel pango-devel wayland-devel libxkbcommon-devel harfbuzz

if [ ! -d "$SRC" ]; then
  git clone https://github.com/philj56/tofi.git "$SRC"
fi

cd "$SRC"
git pull origin master
meson build
ninja -C build install
