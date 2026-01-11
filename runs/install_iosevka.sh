#!/usr/bin/env bash

dots_env_dir="$HOME/.dotfiles/env"
iosevka_dir="$HOME/src/iosevka"
nerd_patcher_dir="$HOME/src/nerd_patcher"

iosevka_config="$dots_env_dir/.config/iosevka/private-build-plans.toml"
fonts_dir="$dots_env_dir/.local/share/fonts/IosevkaNerdFont"

build_tmp="$(mktemp -d -t iosevka-build.XXXXXXXX)"

utils=(
    nodejs
    npm
    ttfautohint
    fontforge
    python3
    wget
    unzip
)

check_prerequisites() {
    if fc-list : family | grep -qi "iosevka nerd font"; then
        echo "[INFO] Custom Iosevka font already installed."
        exit 0
    fi

    for util in "${utils[@]}"; do
        if ! command -v $util >/dev/null 2>&1; then
            sudo dnf install -y $util
        fi
    done
}

dl_and_extract() {
    local name="$1"
    local target_dir="$2"
    local parent_dir="$3"
    local url="$4"
    local zip="$build_tmp/$name.zip"

    if ! wget -O "$zip" "$url"; then
        echo "[ERR ] $zip download failed."
        exit 1
    fi

    unzip -q "$zip" -d "$build_tmp/extract"
    mkdir -p "$target_dir"
    rsync -a --delete "$build_tmp/extract/$parent_dir/" "$target_dir/"
    rm -rf "$build_tmp/extract"
}

build_iosevka() {
    cd "$iosevka_dir" || exit 1
    cp -f "$iosevka_config" ./
    npm ci --prefer-offline --no-audit --quiet
    npm run build -- ttf-unhinted::Iosevka
}

patch_nerd_font() {
    mkdir -p "$build_tmp/patched"

    for ttf in dist/Iosevka/TTF-Unhinted/*.ttf; do
        [[ -f $ttf ]] || continue

        fontforge -script "$nerd_patcher_dir/font-patcher" \
            --complete \
            --careful \
            --progressbars \
            --outputdir "$build_tmp/patched" \
            "$ttf" > /dev/null 2>&1 || true
    done
}

install_font() {
    mkdir -p "$fonts_dir"
    cp -f "$build_tmp/patched"/*.ttf "$fonts_dir/"
    fc-cache -fv
}

main() {
    check_prerequisites

    dl_and_extract "iosevka" \
        $iosevka_dir \
        "Iosevka-main" \
        "https://github.com/be5invis/Iosevka/archive/refs/heads/main.zip"

    dl_and_extract "nerd_patcher" \
        $nerd_patcher_dir \
        "FontPatcher" \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip"

    build_iosevka
    patch_nerd_font
    install_font

    cd $HOME/.dotfiles || exit 1
    stow -R env
}

trap 'rm -rf "$build_tmp"' EXIT

main
