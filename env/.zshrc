# $PATH
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export FZF_DEFAULT_OPTS='
  --color=fg:-1,fg+:#90bbaa,bg:-1,bg+:#21362d
  --color=hl:#f0c3cb,hl+:#ff6b6b,info:#afaf87,marker:#2b879e
  --color=prompt:#f0c3cb,spinner:#d5b3e5,pointer:#d5b3e5,header:#87afaf
  --color=border:#2d493d,label:#aeaeae,query:#d9d9d9
  --padding="1" --prompt="; " --marker="&" --pointer="*"'

# ohmyposh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/titem.toml)"

# aliases
alias rzsh="source $HOME/.zshrc"
alias vim="nvim"
alias dot="cd $HOME/.dotfiles"
alias souen="cd /mnt/yesugei/souen/ && yazi"
alias lzg="lazygit"
alias lzd="lazydocker"

# zplug
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check --verbose; then
  zplug install
fi

zplug load
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

bindkey '^y' autosuggest-accept
