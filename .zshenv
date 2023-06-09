export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export XINITRC="$XDG_CONFIG_HOME"/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export MIX_XDG=1
export EDITOR=/usr/bin/nvim

. "$CARGO_HOME/env"

