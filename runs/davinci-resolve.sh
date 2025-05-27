#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

src_dir="$HOME/src/davinci-resolve"
run_dir="$src_dir/run"
version="20.0"
download_url="https://swr.cloud.blackmagicdesign.com/DaVinciResolve/v$version/DaVinci_Resolve_Studio_$version\_Linux.zip"

cleanup() {
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    log_error "installation failed, cleaning up..."

    if [[ -d "$run_dir" ]]; then
      log_info "removing temporary run directory: $run_dir"
      rm -rf "$run_dir"
    fi

    if [[ -d "/opt/resolve" ]] && [[ ! -f "/opt/resolve/bin/resolve" ]]; then
      log_info "removing partial installation: /opt/resolve"
      sudo rm -rf "/opt/resolve"
    fi

    log_error "Cleanup completed. You can safely re-run this script."
  else
    if [[ -d "$run_dir" ]]; then
      log_info "Cleaning up temporary files"
      rm -rf "$run_dir"
    fi
  fi
}

trap cleanup EXIT

if [ -d /opt/resolve/ ]; then
  log_info "Davinci Resolve already installed, skipping."
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
mkdir -p "$src_dir" "$run_dir"

if [[ ! -f "$src_dir/DaVinci_Resolve_Studio_$version\_Linux.zip" ]]; then
  log_info "downloading DaVinci Resolve..."
  if ! wget -P "$src_dir" "$download_url"; then
    log_error "failed to download DaVinci Resolve"
    exit 1
  fi
fi

if ! unzip "$src_dir"/*.zip -d "$run_dir"; then
  log_error "failed to extract installer"
  exit 1
fi

if ! SKIP_PACKAGE_CHECK=1 "$run_dir"/*.run; then
  log_error "installer failed"
  exit 1
fi

if [[ ! -f "/opt/resolve/bin/resolve" ]]; then
  log_error "installation verification failed - resolve binary not found"
  exit 1
fi

# nvidia drivers
install akmod-nvidia xorg-x11-drv-nvidia-cuda

# codecs
sudo dnf upgrade -y @multimedia --setopt='install_weak_deps=False' --exclude=PackageKit-gstreamer-plugin || true
sudo dnf group install -y sound-and-video || true

# freedom
if ! sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve; then
  log_warn "freedom patch failed"
fi

log_success "DaVinci Resolve installation completed!"
