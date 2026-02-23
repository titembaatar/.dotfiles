source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/titem.toml)"

alias rzsh="source $HOME/.zshrc"
alias rdns="sudo systemctl restart systemd-resolved"
alias lzg="lazygit"
alias lzd="lazydocker"
alias mdu="du -h --max-depth=1 ./"
alias work="cd /mnt/yesugei/souen/ && yazi"
alias poetrade="'$HOME/src/Awakened-PoE-Trade-'*.AppImage --no-overlay --listen=localhost:5555 > /dev/null 2>&1 & disown"
alias poe2trade="'$HOME/src/Exiled-Exchange-'*.AppImage --no-overlay --listen=localhost:5556 > /dev/null 2>&1 & disown"

