#!/usr/bin/env bash

src_dir="$HOME/src"

utils=(git curl make cmake gcc ninja-build gettext glibc-gconv-extra rust cargo openssl-devel mpd)

packages=(
    neovim/neovim
    rvaiya/keyd
)

build() {
    case "$1" in
        'neovim')
            cd "$src_dir/neovim" || exit
            git fetch origin
            git checkout stable
            git pull origin stable
            make CMAKE_BUILD_TYPE=RelWithDebInfo
            sudo make install
            ;;
        'keyd')
            cd "$src_dir/keyd" || exit
            make && sudo make install
            sudo ln -fs "$HOME/.dotfiles/env/.config/keyd/default.conf" /etc/keyd/
            sudo systemctl enable --now keyd
            ;;
        'rmpc')
            cargo install rmpc --locked
            ;;
        'oh-my-posh')
            curl -s https://ohmyposh.dev/install.sh | bash -s
            ;;
    esac
}

install() {
    cmd=$1

    [[ $cmd == 'neovim' ]] && cmd='nvim'

    if ! command -v "$cmd" &>/dev/null; then
        build "$1"
    fi
}

main() {
    mkdir -p "$src_dir"
    sudo dnf install -y "${utils[@]}"

    for package in "${packages[@]}"; do
        if [[ ! -d "$src_dir/${package##*/}" ]]; then
            git clone "https://github.com/$package" "$src_dir/${package##*/}"
        fi
    done

    install neovim
    install keyd
    install rmpc
    install oh-my-posh
}

main
