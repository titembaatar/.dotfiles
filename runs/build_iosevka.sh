#!/usr/bin/env bash

CUSTOM_IOSEVKA_CONFIG=$1
FONT_DIR=$2

[[ -z $FONT_DIR ]] && exit 1
mkdir -p "$FONT_DIR"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
tmp_iosevka="$tmp_dir/iosevka"
tmp_font="$tmp_dir/font"
mkdir -p "$tmp_iosevka" "$tmp_font"

patcher_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip"
wget -qO "$tmp_dir/tmp.zip" "$patcher_url"
unzip -qo "$tmp_dir/tmp.zip" -d "$tmp_dir"

git clone --depth 1 https://github.com/be5invis/Iosevka.git "$tmp_iosevka"

cp -f "$CUSTOM_IOSEVKA_CONFIG" "$tmp_iosevka"
cd "$tmp_iosevka" || exit 1
npm install
if ! npm run build -- ttf::Iosevka --jCmd=16; then
	echo "Iosevka font generation failed"
	exit 1
fi

while IFS= read -r -d '' ttf; do
	t=${ttf#*Iosevka/}
	tmp_ttf="$tmp_font/${t%/*.ttf}"
	fontforge -script "$tmp_dir/font-patcher" --careful --quiet \
		--variable-width-glyphs --complete --adjust-line-height \
		--outputdir "$tmp_ttf" "$ttf"
done < <(find "$tmp_iosevka/dist/Iosevka" -name "*.ttf" -print0)

cp -r "$tmp_font"/TTF/* "$FONT_DIR"
