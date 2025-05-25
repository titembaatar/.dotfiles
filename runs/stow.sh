#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

install stow

cd "$HOME"/.dotfiles/
stow env
