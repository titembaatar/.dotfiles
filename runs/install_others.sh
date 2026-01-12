#!/usr/bin/env bash

src_dir="$HOME/src"

utils=(
    ninja-build
    cmake
    gcc
    make
    gettext
    curl
    glibc-gconv-extra
)

packages=(
    neovim/neovim
    rvaiya/keyd
)

build_neovim() {
    cd "$src_dir"/neovim || exit
    git fetch origin
    git checkout stable
    git pull origin stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
}

build_keyd() {
    cd "$src_dir"/keyd || exit
    make && sudo make install
    sudo ln -fs "$HOME"/.dotfiles/env/.config/keyd/default.conf /etc/keyd/
    sudo systemctl enable --now keyd
}

main() {
    mkdir -p "$src_dir"

    for util in "${utils[@]}"; do
        if ! command -v "$util"; then
            sudo dnf install -y "$util"
        fi
    done

    for package in "${packages[@]}"; do
        git clone https://github.com/"$package" "$src_dir"
    done

    build_neovim
    build_keyd

    if ! command -v oh-my-posh; then
        curl -s https://ohmyposh.dev/install.sh | bash -s
    fi
}

main
