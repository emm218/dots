#!/bin/sh

PATH=$PATH:$HOME/.local/bin
export MANPATH=$(manpath)

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export GTK_IM_MODULE=xim
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export XIM_PROGRAM=ibus
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export TERMINFO=$XDG_DATA_HOME/terminfo
export TERMINFO_DIRS=$XDG_DATA_HOME/terminfo:/usr/share/terminfo
export MIX_XDG=1

. $CARGO_HOME/env

exec 2> $XDG_STATE_HOME/.xsession-errors
rm -f .xsession-errors

rm -f $HOME/pics/screenshots/*.png
mpv --no-audio-display $HOME/.local/share/startup.wav &
ibus-daemon -drxR
fehbg
pidof mpd || mpd
pidof mpdas || mpdas -d
pidof redshift || redshift &
picom -b
dwmblocks &
mpdup &
remaps
exec ssh-agent dwm
