#!/usr/bin/env bash
set -e
source "$HOME"/dotfiles/pkg

install zsh

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
