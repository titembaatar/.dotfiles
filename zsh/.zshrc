# $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/git/lua-language-server/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH:$HOME/go/bin"

# ohmyposh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/titem.toml)"

# aliases
alias lzg="lazygit"
alias lzd="lazydocker"

# directories
## work
export draw=/mnt/yesugei/souen/raw/
export drender=/mnt/yesugei/souen/render/
export dmega=/mnt/yesugei/souen/mega/

## homelab
export dcompose=/mnt/borte/homelab/compose/
export dvolume=/mnt/borte/homelab/volumes/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

