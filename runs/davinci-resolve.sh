#!/usr/bin/env bash
set -e

SRC="$HOME/src/davinci-resolve"
RUN="$SRC/run"
DAV_URL="https://swr.cloud.blackmagicdesign.com/DaVinciResolve/v20.0b3/DaVinci_Resolve_Studio_20.0b3_Linux.zip"

# RPM Fusion
if dnf repo list | grep -q 'rpmfusion-free'; then
  sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
fi

# dependencies
sudo dnf install -y libxcrypt-compat libcurl libcurl-devel mesa-libGLU fuse-libs unzip
sudo dnf mark dependency libxcrypt-compat libcurl libcurl-devel mesa-libGLU fuse-libs unzip

# wget davinci resolve
mkdir -p "$SRC"
mkdir -p "$RUN"
wget -P "$SRC" "$DAV_URL"
unzip "$SRC"/*.zip -d "$RUN"

SKIP_PACKAGE_CHECK=1 "$RUN"/*.run

# maybe remove installer
# rm -rf "$RUN"

# nvidia drivers
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
sudo dnf mark user akmod-nvidia xorg-x11-drv-nvidia-cuda

# codecs
sudo dnf upgrade @multimedia --setopt='install_weak_deps=False' --exclude=PackageKit-gstreamer-plugin
sudo dnf group install -y sound-and-video

# freedom
sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve
