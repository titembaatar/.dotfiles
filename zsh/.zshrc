# $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/git/lua-language-server/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH:$HOME/go/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# ohmyposh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/titem.toml)"

# aliases
alias lzg="lazygit"

# directories
## work
export draw=/mnt/yesugei/souen/raw/
export drender=/mnt/yesugei/souen/render/
export dmega=/mnt/yesugei/souen/mega/

## homelab
export dcompose=/mnt/borte/homelab/compose/
export dvolume=/mnt/borte/homelab/volumes/
