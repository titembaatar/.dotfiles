#!/usr/bin/env bash
set -e
source $HOME/.dotfiles/pkg

src_dir="$HOME/src/davinci-resolve"
run_dir="$src_dir/run"
version="20.3.1"
# download_url="https://swr.cloud.blackmagicdesign.com/DaVinciResolve/v${version}/DaVinci_Resolve_Studio_${version}_Linux.zip?verify=1767795975-1His%2BGe%2B7rua5hdAihCvkbtxT423ttcxJsXHbvcqYKw%3D"

cleanup() {
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    log_error "installation failed, cleaning up..."

    if [[ -d $run_dir ]]; then
      log_info "removing temporary run directory: $run_dir"
      rm -rf "$run_dir"
    fi

    if [[ -d "/opt/resolve" ]] && [[ ! -f "/opt/resolve/bin/resolve" ]]; then
      log_info "removing partial installation: /opt/resolve"
      sudo rm -rf "/opt/resolve"
    fi

    log_error "Cleanup completed. You can safely re-run this script."
  else
    if [[ -d $run_dir ]]; then
      log_info "Cleaning up temporary files"
      rm -rf "$run_dir"
    fi
  fi
}

trap cleanup EXIT

if [ -d "/opt/resolve/" ]; then
  log_info "DaVinci Resolve is already installed at /opt/resolve."
  read -r -p "Would you like to reinstall DaVinci Resolve? This will remove the existing installation. (y/N): " response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    log_info "Removing existing DaVinci Resolve installation..."
    sudo rm -rf "/opt/resolve"
  else
    log_info "Skipping installation."
    exit 0
  fi
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
mkdir -p $src_dir $run_dir

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
cd /opt/resolve
sudo perl -pi -e 's/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\x74\x11\x48\x8B\x45\xC8\x8B/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\xEB\x11\x48\x8B\x45\xC8\x8B/' bin/resolve
sudo perl -pi -e 's/\x74\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/\xEB\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/' bin/resolve
sudo perl -pi -e 's/\x41\xb6\x01\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/\x41\xb6\x00\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/' bin/resolve
echo -e "LICENSE blackmagic davinciresolvestudio 999999 permanent uncounted\n  hostid=ANY issuer=CGP customer=CGP issued=28-dec-2023\n  akey=0000-0000-0000-0000 _ck=00 sig=\"00\"" | sudo tee .license/blackmagic.lic

log_success "DaVinci Resolve installation completed!"
