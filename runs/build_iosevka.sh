#!/usr/bin/env bash

INSTALL_CMD=$1
ENV_DIR=$2
font_dir=$3

[[ -z $font_dir ]] && exit 1
mkdir -p "$font_dir"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
tmp_iosevka="$tmp_dir/iosevka"
tmp_font="$tmp_dir/font"
mkdir -p "$tmp_iosevka" "$tmp_font"

patcher_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip"
wget -qO "$tmp_dir/tmp.zip" "$patcher_url"
unzip -qo "$tmp_dir/tmp.zip" -d "$tmp_dir"

git clone --depth 1 https://github.com/be5invis/Iosevka.git "$tmp_iosevka"

$INSTALL_CMD nodejs npm ttfautohint fontforge python3 wget unzip

cd "$tmp_iosevka" || exit 1
cp -f "$ENV_DIR/.config/iosevka/private-build-plans.toml" ./
npm install
if ! npm run build -- ttf::Iosevka --jCmd=16; then
	echo "Iosevka font generation failed"
	exit 1
fi

while IFS= read -r -d '' ttf; do
	echo "Patching $ttf..."
	t=${ttf#*Iosevka/}
	t=${t%/*.ttf}
	tmp_ttf="$tmp_font/$t"
	fontforge -script "$tmp_dir/font-patcher" --complete \
		--careful --progressbars --outputdir "$tmp_ttf" \
		"$ttf"
done < <(find "$tmp_iosevka/dist/Iosevka" -name "*.ttf" -print0)

cp -r "$tmp_font/TTF/"* "$font_dir/"
