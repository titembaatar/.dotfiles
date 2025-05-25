#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

sudo dnf copr enable -y sneexy/zen-browser
install zen-browser
