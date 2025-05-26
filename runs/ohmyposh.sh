#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

if [ -f $HOME/.local/bin/oh-my-posh ];then
  log_info "oh my posh already installed. Skipping."
  exit 0
fi

curl -s https://ohmyposh.dev/install.sh | bash -s
