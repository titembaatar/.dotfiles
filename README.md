## titem's .dotfiles

### init
```bash
git clone ssh://git@codeberg.org/titembaatar/.dotfiles.git $HOME/
chmod -R +x $HOME/.dotfiles/runs/
$HOME/.dotfiles/runs/init
```

### sway
If using a `nvidia gpu` replace `Exec` in `/usr/share/wayland-sessions/sway.desktop` with:
```
Exec=sway --unsupported-gpu
```
