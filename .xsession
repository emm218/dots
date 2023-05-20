#!/bin/sh

PATH=$PATH:$HOME/.local/bin:/usr/lib/ruby/gems/3.1.0/bin
export MANPATH=$(manpath)

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export XIM_PROGRAM=fcitx5
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export TERMINFO=$XDG_DATA_HOME/terminfo
export TERMINFO_DIRS=$XDG_DATA_HOME/terminfo:/usr/share/terminfo
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch-config
export MIX_XDG=1
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export EDITOR=/usr/bin/nvim

. $CARGO_HOME/env

exec 2> $XDG_STATE_HOME/.xsession-errors
rm -f .xsession-errors

fehbg
pipewire &
pidof mpd || mpd
pidof redshift || redshift &
xbacklight -set 10
picom -b
remaps
fcitx5 -r &
wireplumber &
pipewire-pulse &
exec ssh-agent dwm
