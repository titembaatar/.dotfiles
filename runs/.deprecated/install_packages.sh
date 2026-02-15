#!/usr/bin/env bash

packages=(
	lua
	luarocks
	fzf
	stow
	sway
	tmux
	waybar
	zsh
	chafa
	steam
	vlc
	obs-studio
)

copr_packages=(
	"scottames/ghostty"
	"lihaohong/yazi"
)

sudo dnf install -y "${packages[@]}"

for copr_package in "${copr_packages[@]}"; do
	sudo dnf copr enable "$copr_package"
done

sudo dnf install -y "${copr_packages[@]##*/}"

