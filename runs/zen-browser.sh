#!/usr/bin/env bash
set -e

sudo dnf copr enable sneexy/zen-browser
sudo dnf install -y zen-browser
sudo dnf mark user zen-browser
