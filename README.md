# 📄 dotfiles
My personal configuration files.

## 📦 Installation Guide
### 📌 stow
```bash
sudo dnf install stow
```

### 🚀 neovim
```bash
cd ~/.dotfiles
stow nvim
sudo dnf install neovim
```

If the config needs to be used with `sudo`:
```bash
sudo mkdir -p /root/.config/
sudo ln -r ~/.config/nvim/ /root/.config/nvim/
```

### 🖥️ terminal enhancements
```bash
cd ~/.dotfiles
stow kitty zsh ohmyposh
sudo dnf install kitty zsh curl unzip
chsh -s $(which zsh)
curl -s https://ohmyposh.dev/install.sh | bash -s
```

### 🪟 tmux
```bash
cd ~/.dotfiles
stow tmux
mkdir -p ~/.config/tmux/plugins/tpm
sudo dnf install tmux 
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
```

## 🌳 sway window manager
### 🔍 tofi launcher
```bash
cd ~/.dotfiles
stow tofi
sudo dnf install meson scdoc wayland-protocols-devel freetype-devel cairo-devel pango-devel wayland-devel libxkbcommon-devel harfbuzz
mkdir -p ~/git
cd ~/git
git clone https://github.com/philj56/tofi.git
cd tofi
meson build && ninja -C build install
```

### 🛠️ wayland utilities
```bash
cd ~/.dotfiles
stow cursors fonts waybar
sudo dnf install waybar grimshot
```

### 🌲 sway setup
```bash
cd ~/.dotfiles
stow sway 
sudo dnf install sway 
```
If using an `nvidia gpu`:
```bash
cd /usr/share/wayland-sessions
sudo nvim sway.desktop
```
and replace `Exec` with:
```
Exec=sway --unsupported-gpu
```
