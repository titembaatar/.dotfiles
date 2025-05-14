#!/usr/bin/env bash
set -e

sudo dnf mark install -y stow
stow "$HOME"/.dotfiles/env/
