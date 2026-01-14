#!/usr/bin/env bash

packages=(
    alacritty
    cmus
    fzf
    stow
    sway
    tmux
    waybar
    zsh
)

copr_packages=(
    "lihaohong/yazi"
    "sneexy/zen-browser"
    "scottames/ghostty"
)

sudo dnf install -y "${packages[@]}"

for copr_package in "${copr_packages[@]}"; do
    sudo dnf copr enable "$copr_package"
done

sudo dnf install -y "${copr_packages[@]##*/}"

