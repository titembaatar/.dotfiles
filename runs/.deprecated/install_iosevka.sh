#!/usr/bin/env bash

build_tmp="$(mktemp -d /tmp/iosevka-build)"
trap 'rm -rf "$build_tmp"' EXIT

dots_env_dir="$HOME/.dotfiles/env"
iosevka_dir="$HOME/src/iosevka"
font_patcher_dir="$HOME/src/nerd_patcher"
fonts_dir="$dots_env_dir/.local/share/fonts/IosevkaNerdFont"

utils=(nodejs npm ttfautohint fontforge python3 wget unzip)

check_prerequisites() {
	if fc-list : family | grep -qi "iosevka nerd font"; then
		echo "[INFO] Custom Iosevka font already installed."
		exit 0
	fi

	sudo dnf install -y "${utils[@]}"
}

dl_and_extract() {
	local url=$1
	local target_dir=$2

	mkdir -p "$target_dir" "$build_tmp/extract"
	wget -qO "$build_tmp/tmp.zip" "$url" || exit 1
	unzip -qo "$build_tmp/tmp.zip" -d "$build_tmp/extract"
	mv "$build_tmp"/extract/*/* "$target_dir/"
	rm -rf "$build_tmp/extract" "$build_tmp/tmp.zip"
}

build_iosevka() {
	cd "$iosevka_dir" || exit 1
	cp -f "$dots_env_dir/.config/iosevka/private-build-plans.toml" ./
	npm ci --prefer-offline --no-audit --quiet
	npm run build -- ttf-unhinted::Iosevka
}

patch_nerd_font() {
	mkdir -p "$build_tmp/patched"

	while IFS= read -r -d '' ttf; do
		fontforge -script "$font_patcher_dir/font-patcher" \
			--complete \
			--careful \
			--progressbars \
			--outputdir "$build_tmp/patched" \
			"$ttf" > /dev/null 2>&1 || true
	done < <(find dist/Iosevka/TTF-Unhinted/ -name "*.ttf" -print0)
}

install_font() {
	mkdir -p "$fonts_dir"
	cp -f "$build_tmp"/patched/*.ttf "$fonts_dir/"
	fc-cache -fv
}

main() {
	check_prerequisites

	local iosevka_url="https://github.com/be5invis/Iosevka/archive/refs/heads/main.zip"
	dl_and_extract "$iosevka_url" "$iosevka_dir"

	local font_patcher_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip"
	dl_and_extract "$font_patcher_url" "$font_patcher_dir"

	build_iosevka
	patch_nerd_font
	install_font

	stow -d "$HOME/.dotfiles" -t "$HOME" env
}

main
