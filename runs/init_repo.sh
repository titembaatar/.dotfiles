#!/usr/bin/env bash

repos=(
    # host:repo:dest
    "codeberg.org:titembaatar/sarnai:$HOME/personal"
    "codeberg.org:titembaatar/sarnai.nvim:$HOME/personal"
    "codeberg.org:titembaatar/homelab:$HOME/personal"
    "github.com:titembaatar/glance:$HOME/forks"
    "github.com:titembaatar/glance-widgets:$HOME/forks"
    "github.com:neovim/neovim:$HOME/src"
)

check_prereq() {
    if ! command -v git &>/dev/null; then
        sudo dnf install git
    fi

    mkdir -p "$HOME"/{personal,forks,src}
}

git_clone() {
    IFS=: read -r host repo dest <<< "$1"

    if [[ -d $dest/${repo##*/} ]]; then
        echo "[INFO] $repo already cloned at $dest"
        return 0
    fi

    git clone --recurse-submodules "ssh://git@$host/$repo.git" "$dest"
}

main() {
    check_prereq

    for repo in "${repos[@]}"; do
        git_clone "$repo"
    done
}

main
