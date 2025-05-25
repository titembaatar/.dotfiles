#!/usr/bin/env bash
set -e
source "$HOME"/.dotfiles/pkg

SRC="$HOME/src/davinci-resolve"
RUN="$SRC/run"
VERSION="20.0"
DAV_URL="https://swr.cloud.blackmagicdesign.com/DaVinciResolve/v$VERSION/DaVinci_Resolve_Studio_$VERSION\_Linux.zip"

if [ -d /opt/resolve/ ]; then
  log_info "Davinci Resolve already installed. Skipping."
  exit 0
fi

# RPM Fusion
if ! dnf repolist | grep -q 'rpmfusion-free'; then
  sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
fi

# dependencies
install libxcrypt-compat libcurl libcurl-devel mesa-libGLU fuse-libs unzip wget

# wget davinci resolve
mkdir -p "$SRC" "$RUN"

if [[ ! -f "$SRC/DaVinci_Resolve_Studio_$VERSION\_Linux.zip" ]]; then
  wget -P "$SRC" "$DAV_URL"
fi

unzip "$SRC"/*.zip -d "$RUN"
SKIP_PACKAGE_CHECK=1 "$RUN"/*.run

# nvidia drivers
install akmod-nvidia xorg-x11-drv-nvidia-cuda

# codecs
sudo dnf upgrade -y @multimedia --setopt='install_weak_deps=False' --exclude=PackageKit-gstreamer-plugin || true
sudo dnf group install -y sound-and-video || true

# freedom
sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve

# cleanup
rm -rf "$RUN"
