# .bashrc

# Perso
eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/titem.toml)"
export PATH=$PATH:/home/titem/.local/bin

# . "$HOME/.cargo/env"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export PATH=$PATH:$(go env GOPATH)/bin

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

