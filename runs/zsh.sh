#!/usr/bin/env bash
set -e

sudo dnf install -y zsh
sudo dnf mark user zsh

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
