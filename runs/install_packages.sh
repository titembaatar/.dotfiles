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

for package in "${packages[@]}"; do
    sudo dnf install -y "$package"
done

for copr_package in "${copr_packages[@]}"; do
    sudo dnf copr enable "$copr_package"

    package_name=${copr_package##*/}
    sudo dnf install -y "$package_name"
done

