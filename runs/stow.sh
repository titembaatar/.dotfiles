#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

install stow

stow "$HOME"/.dotfiles/env/
