#!/usr/bin/env bash
set -e

sudo dnf copr enable -y lihaohong/yazi
sudo dnf install -y yazi
sudo dnf mark user yazi

