#!/usr/bin/env bash

declare -A repos=(
    ["codeberg.org/titembaatar/sarnai"]="$HOME/personal"
    ["codeberg.org/titembaatar/sarnai.nvim"]="$HOME/personal"
    ["codeberg.org/titembaatar/homelab"]="$HOME/personal"
    ["github.com/titembaatar/glance"]="$HOME/forks"
    ["github.com/titembaatar/glance-widgets"]="$HOME/forks"
    ["github.com/neovim/neovim"]="$HOME/src"
)

check_prereq() {
    if ! command -v git &>/dev/null; then
        sudo dnf install git
    fi

    mkdir -p $HOME/{personal,forks,src}
}

git_clone() {
    local repo="$1"
    local dest="$2/${1##./}"

    if [[ -d "$dest" ]]; then
        echo "[INFO] $repo already cloned at $dest"
        return 0
    fi

    git clone --recurse-submodules ssh://git@"$repo".git $dest
}

main() {
    check_prereq

    for repo in "${!repos[@]}"; do
        git_clone $repo ${repos[$repo]}
    done
}

main
