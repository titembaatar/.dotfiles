#!/usr/bin/env bash
set -e

sudo dnf install -y stow
sudo dnf mark user stow
stow "$HOME"/.dotfiles/env/
