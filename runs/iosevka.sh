#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

if [ -f $HOME/.dotfiles/env/.local/share/fonts/IosevkaNerdFont/IosevkaNerdFont-Regular.ttf ]; then
  log_info "Custom Iosevka font already installed."
  exit 0
fi

src_dir="$HOME/src/Iosevka"
nerd_fonts_patcher="$HOME/src/nerd-fonts-patcher"
fonts_dir="$HOME/.dotfiles/env/.local/share/fonts/IosevkaNerdFont"
tmp_dir="/tmp/iosevka-build"

install nodejs npm ttfautohint fontforge python3 wget unzip

if [ ! -d $src_dir ]; then
  mkdir -p "$(dirname $src_dir)"
  wget -O /tmp/iosevka.zip https://github.com/be5invis/Iosevka/archive/refs/heads/main.zip
  unzip /tmp/iosevka.zip -d /tmp/
  mv /tmp/Iosevka-main $src_dir
  rm /tmp/iosevka.zip
fi

if [ ! -d $nerd_fonts_patcher ]; then
  mkdir -p $nerd_fonts_patcher
  wget -O /tmp/FontPatcher.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
  unzip /tmp/FontPatcher.zip -d $nerd_fonts_patcher
  rm /tmp/FontPatcher.zip
fi

cd $src_dir

cp "$HOME/.config/iosevka/private-build-plans.toml" ./
npm install
npm run build -- ttf-unhinted::Iosevka

tmp_dir="/tmp/iosevka-build"

if [[ -z $tmp_dir || $tmp_dir == "/" || $tmp_dir == "/tmp" ]]; then
  log_error "invalid TEMP_DIR value: '$tmp_dir'"
  exit 1
fi

mkdir -p $tmp_dir
[[ -d $tmp_dir ]] && rm -rf "${tmp_dir:?}"/*

cp dist/Iosevka/TTF-Unhinted/*.ttf "$tmp_dir/"

cd $nerd_fonts_patcher

for font_file in "$tmp_dir"/*.ttf; do
  log_info "patching $(basename "$font_file")..."
  fontforge -script font-patcher \
    --complete \
    --careful \
    --progressbars \
    --outputdir "$tmp_dir/patched" \
    "$font_file"
done

mkdir -p $fonts_dir
cp "$tmp_dir/patched"/*.ttf "$fonts_dir/"

if [[ -d $tmp_dir && $tmp_dir != "/" && $tmp_dir != "/tmp" ]]; then
  rm -rf "${tmp_dir:?}"
fi

fc-cache -fv

cd $HOME/.dotfiles
stow env

echo
log_success "Iosevka Nerd Font installation completed!"
