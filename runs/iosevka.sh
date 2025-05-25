#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

if [ -f "$HOME"/.dotfiles/env/.local/share/fonts/IosevkaNerdFont/IosevkaNerdFont-Regular.ttf ]; then
  log_info "Custom Iosevka font already installed."
  exit 0
fi

IOSEVKA_SRC="$HOME/src/Iosevka"
NERD_FONTS_PATCHER="$HOME/src/nerd-fonts-patcher"
FONT_OUTPUT_DIR="$HOME/.dotfiles/env/.local/share/fonts/IosevkaNerdFont"
TEMP_DIR="/tmp/iosevka-build"

install nodejs npm ttfautohint fontforge python3 wget unzip

if [ ! -d "$IOSEVKA_SRC" ]; then
  mkdir -p "$(dirname "$IOSEVKA_SRC")"
  wget -O /tmp/iosevka.zip https://github.com/be5invis/Iosevka/archive/refs/heads/main.zip
  unzip /tmp/iosevka.zip -d /tmp/
  mv /tmp/Iosevka-main "$IOSEVKA_SRC"
  rm /tmp/iosevka.zip
fi

if [ ! -d "$NERD_FONTS_PATCHER" ]; then
  mkdir -p "$NERD_FONTS_PATCHER"
  wget -O /tmp/FontPatcher.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip
  unzip /tmp/FontPatcher.zip -d "$NERD_FONTS_PATCHER"
  rm /tmp/FontPatcher.zip
fi

cd "$IOSEVKA_SRC"

cp "$HOME/.config/iosevka/private-build-plans.toml" ./
npm install
npm run build -- ttf-unhinted::Iosevka

TEMP_DIR="/tmp/iosevka-build"
if [[ -z "$TEMP_DIR" || "$TEMP_DIR" == "/" || "$TEMP_DIR" == "/tmp" ]]; then
  log_error "invalid TEMP_DIR value: '$TEMP_DIR'"
  exit 1
fi

mkdir -p "$TEMP_DIR"
[[ -d "$TEMP_DIR" ]] && rm -rf "${TEMP_DIR:?}"/*

cp dist/Iosevka/TTF-Unhinted/*.ttf "$TEMP_DIR/"

cd "$NERD_FONTS_PATCHER"

for font_file in "$TEMP_DIR"/*.ttf; do
  log_info "patching $(basename "$font_file")..."
  fontforge -script font-patcher \
    --complete \
    --careful \
    --progressbars \
    --outputdir "$TEMP_DIR/patched" \
    "$font_file"
done

mkdir -p "$FONT_OUTPUT_DIR"
cp "$TEMP_DIR/patched"/*.ttf "$FONT_OUTPUT_DIR/"

if [[ -d "$TEMP_DIR" && "$TEMP_DIR" != "/" && "$TEMP_DIR" != "/tmp" ]]; then
  rm -rf "${TEMP_DIR:?}"
fi

fc-cache -fv

cd "$HOME"/.dotfiles
stow env

echo
log_success "Iosevka Nerd Font installation completed!"
