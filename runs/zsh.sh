#!/usr/bin/env bash
set -e

sudo dnf mark install -y zsh

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
