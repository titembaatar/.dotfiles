#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

src_dir="$HOME/src/tofi"

if [ -d "$src_dir" ]; then
  log_info "tofi already installed"
  exit 0
fi

install meson scdoc wayland-protocols-devel freetype-devel cairo-devel pango-devel wayland-devel libxkbcommon-devel harfbuzz

if [ ! -d "$src_dir" ]; then
  git clone https://github.com/philj56/tofi.git "$src_dir"
fi

cd "$src_dir"
git pull origin master
meson build
ninja -C build install
