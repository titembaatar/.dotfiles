#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

src_dir="$HOME/src/discordo"

if command -v discordo;then
  log_info "discordo already installed, skipping."
fi

mkdir -p $src_dir
git clone https://github.com/ayn2op/discordo $src_dir
cd $src_dir
go build .
cp discordo $HOME/.local/bin/

eval $(gnome-keyring-daemon --start)
export $(gnome-keyring-daemon --start)

log_info "enter token:"
secret-tool store --label="Discord Token" service discordo username token
