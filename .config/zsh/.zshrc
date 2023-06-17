autoload -U colors && colors

setopt autocd
setopt prompt_subst

if [ -f ~/.local/share/git-prompt.sh ]; then
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_SHOWCOLORHINTS=true
source ~/.local/share/git-prompt.sh
else
PS1='%{$fg_bold[magenta]%}%~ %b%f$(__git_ps1 "(%s) ")%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})> %b%f'
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

export GPG_TTY=$(tty)

bindkey -e

autoload -U compinit
zstyle ':completion:*' menu select cache-path $XDG_CACHE_HOME/zsh/zcompcache
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
_comp_options+=(globdots)

fzcd () {
    choice=$(fd -H . "$HOME" -tdirectory | \
        fzf --scheme=path --color=16,fg+:magenta,prompt:green,pointer:green)
    if [ "$choice" ]; then
        cd "$choice"
        clear
        precmd
        zle reset-prompt
    fi
}

zle -N fzcd

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
	__git_ps1 '%{$fg_bold[magenta]%}%~ %b%f' '%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})> %b%f' '(%s) '
}

preexec () {
	xtitle "$1"
}

ex () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.*)     tar xf $1      ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

bindkey '^o' fzcd
bindkey -s '^f' 'fg\n'
bindkey -s '^h' 'cd\n'
bindkey -s '^r' 'rl\n'

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

alias rl=". ~/.config/zsh/.zshrc"
alias sudo="doas"
alias vim="nvim"
alias vi="nvim"
alias xbps-install="doas xbps-install"
alias xbps-remove="doas xbps-remove"
alias xbps-search="xbps-query -Rs"
alias xbps-update='xbps-install -Syu && kill -46 $(pidof dwmblocks)'
alias ls="exa -s Name"
alias ll="exa -l -s Name"
alias less="less -R"
alias newsboat="newsboat --url-file=~/.config/newsboat/urls"
alias config='git --git-dir="$XDG_CONFIG_HOME/dots.git" --work-tree="$HOME"'
alias sudoedit="doas-edit"
alias psg="ps aux | grep"
alias parts="mount -v | grep '^/' | awk '"'{print "Partition ID: " $1 "\n Mountpoint: " $3}'"'"
alias vicfg="vi ~/.config/nvim/init.vim"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

