#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

if ! command -v git &>/dev/null; then
  install git
fi

git_clone() {
  if [ -d "$4$3" ]; then
    return 0
  fi

  if [ "$1" = 1 ]; then
    git clone --recurse-submodules git@github.com:"$2"/"$3".git "$4"
  else
      git clone git@github.com:"$2"/"$3".git "$4"
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

git_clone 1 "titembaatar" ".dotfiles" "$HOME/"

git_clone 0 "titembaatar" "sarnai" "$HOME/personal/"
git_clone 0 "titembaatar" "sarnai.nvim" "$HOME/personal/"

git_clone 0 "titembaatar" "glance" "$HOME/forks/"
git_clone 0 "titembaatar" "glance-widgets" "$HOME/forks/"

git_clone 0 "neovim" "neovim" "$HOME/src/"
