autoload -U colors && colors
setopt prompt_subst
PS1="%{$fg_bold[magenta]%}%~ %(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})> %b%f"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -U compinit
zstyle ':completion:*' menu select cache-path $XDG_CACHE_HOME/zsh/zcompcache
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)

lfcd () {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}

case "$TERM" in
	st*|xterm*|rxvt*)
		xtitle () {
			echo -ne "\033];$@\007"
		}
		;;
	*)
		xtitle () {
		}
esac

precmd () {
	xtitle "$(print -D $PWD)"	
}

preexec () {
	xtitle "$1"
}

bindkey -s '^o' 'lfcd\n'
bindkey -s '^f' 'fg\n'

alias sudo="doas"
alias vim="nvim"
alias vi="nvim"
alias xbps-install="doas xbps-install"
alias xbps-remove="doas xbps-remove"
alias xbps-search="xbps-query -Rs"
alias xbps-update='xbps-install -Syu && kill -46 $(pidof dwmblocks)'
alias ls="ls --color"
alias less="less -R"
alias newsboat="newsboat --url-file=~/.config/newsboat/urls"
alias fd="fd -H"
alias config='git --git-dir="$XDG_CONFIG_HOME/dots.git" --work-tree="$HOME"'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
