# Stuff to install

## stow
```bash
sudo dnf install stow
```

## neovim
```bash
cd ~/.dotfiles
stow nvim
mkdir -p ~/code
cd ~/code
git clone git@github.com:titembaatar/sarnai.nvim.git
sudo dnf install neovim
```

## terminal stuff
```bash
cd ~/.dotfiles
stow kitty bash zsh ohmyposh
sudo dnf install kitty zsh
curl -s https://ohmyposh.dev/install.sh | bash -s
```

### tmux
```bash
cd ~/.dotfiles
stow tmux
sudo dnf install tmux 
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
```

## sway
```bash
cd ~/.dotfiles
stow cursors fonts sway waybar
sudo dnf install sway waybar grimshot
```

### tofi install
```bash
cd ~/.dotfiles
stow tofi
sudo dnf intall meson scdoc wayland-protocols-devel freetype-devel cairo-devel pango-devel wayland-devel libxkbcommon-devel harfbuzz
mkdir -p ~/git
cd ~/git
git clone https://github.com/philj56/tofi.git
cd tofi
meson build && ninja -C build install
```
