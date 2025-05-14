#!/usr/bin/env bash
set -e

sudo dnf copr enable sneexy/zen-browser
sudo dnf mark install -y zen-browser
