#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

if ! command -v git &>/dev/null; then
  install git
fi

git_clone() {
  if [ -d "$2" ]; then
    log_info "$2.git exists, skipping"
    return 0
  fi

  git clone git@github.com:"$1"/"$2".git
}

git_clone_with_submodule() {
  if [ -d "$2" ]; then
    log_info "$2.git exists, skipping"
    return 0
  fi

  git clone --recurse-submodules git@github.com:"$1"/"$2".git
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
git_clone_with_submodule "titembaatar" ".dotfiles"

cd "$HOME/personal/"
git_clone "titembaatar" "sarnai"
git_clone "titembaatar" "sarnai.nvim"
git_clone "titembaatar" "homelab"

cd "$HOME/forks/"
git_clone "titembaatar" "glance"
git_clone "titembaatar" "glance-widgets"

cd "$HOME/src/"
git_clone "neovim" "neovim"
