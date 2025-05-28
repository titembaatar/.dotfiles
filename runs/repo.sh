#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

if ! command -v git &>/dev/null; then
  install git
fi

git_clone() {
  if [ -d "$3" ]; then
    log_info "$3.git exists, skipping"
    return 0
  fi

  if [ "$1" = 1 ]; then
    git clone --recurse-submodules git@github.com:"$2"/"$3".git
  else
    git clone git@github.com:"$2"/"$3".git
  fi
}

make_dir() {
  if [ ! -d "$HOME/$1" ]; then
    mkdir -p "$HOME/$1"
  fi
}

make_dir ".dotfiles"
make_dir "personal"
make_dir "forks"
make_dir "src"

cd "$HOME"
git_clone 1 "titembaatar" ".dotfiles" "$HOME/.dotfiles"

cd "$HOME/personal/"
git_clone 0 "titembaatar" "sarnai"
git_clone 0 "titembaatar" "sarnai.nvim"
git_clone 0 "titembaatar" "homelab"

cd "$HOME/forks/"
git_clone 0 "titembaatar" "glance"
git_clone 0 "titembaatar" "glance-widgets"

cd "$HOME/src/"
git_clone 0 "neovim" "neovim"
