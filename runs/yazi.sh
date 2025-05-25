#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

sudo dnf copr enable -y lihaohong/yazi
install yazi

