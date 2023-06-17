export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export XINITRC="$XDG_CONFIG_HOME"/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export MIX_XDG=1
export EDITOR=/usr/bin/nvim
export MANPATH="$XDG_DATA_HOME"/man:
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export XIM_PROGRAM=fcitx
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch-config
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export TERMINFO=$XDG_DATA_HOME/terminfo
export TERMINFO_DIRS=$XDG_DATA_HOME/terminfo:/usr/share/terminfo

export PATH=$PATH:$HOME/.local/bin

. "$CARGO_HOME/env"

