# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/gems/bin:$HOME/core/codeql-home/codeql

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Custom ZSH customization dir
ZSH_CUSTOM=$HOME/.config/zsh-custom

# Set name of the theme to load
ZSH_THEME="hyper-minimal"

# load plugins
plugins=(gitfast rsync vi-mode)

# load ohmyzsh
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi


_systemctl_unit_state() {
    typeset -gA _sys_unit_state
        _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') ) }

# ruby gems setup
export GEM_HOME=$HOME/gems

# this is for agnostr theme
#DEFAULT_USER=`whoami`
# this is for dynamic window renaming with tmux+alacritty
preexec() { print -Pn "\e]0;%~: $1\a" }

# ssh agent service socket
#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.
#
# load private aliases
#. $ZSH_CUSTOM/aliases.zsh

alias zshreload="omz reload"

# open config files
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias i3config="vim ~/.config/i3/config"
alias swaycfg="vim ~/.config/sway/config"

# better default ls and variants
LSBIN=$(bash -c "which ls")
alias l="$LSBIN--color=auto"
alias ls="$LSBIN -l --color=auto --group-directories-first"
alias la="$LSBIN -A"
alias sl="$LSBIN"

# git aliases
alias gpo="git push origin $(git_current_branch)"
alias gstat="git status"

# command wrappers
alias vim="nvim"
# alias bat="batcat"
alias apti="sudo apt install"
alias dl="wget"
alias ff="fzf"
alias c="clear"
alias mkx="chmod +x"
alias rmf="rm -rf"
alias cpa="cp -a"
alias psfind="ps aux | grep"

# media
alias yv="mpv --cache-pause-initial=yes --ytdl-format='bestvideo[height<=720]+bestaudio/best'"
alias ya="mpv --ytdl-format='bestaudio/best'"

# tmux aliases
alias tmls="tmux ls"
alias tma="tmux attach -t"
alias tmn="tmux new -s"

# check listening ports
alias lptun="sudo ss -lptun"

# alias for managing tty-dotfiles git repo
alias ttycfg='git --git-dir=$HOME/.tty-dotfiles/ --work-tree=$HOME'
alias ttystatus='ttycfg status'
alias ttycomm='ttycfg commit -m'

# alias for managing dotfiles with bare git directory
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias confstat="config status"
alias commitconf="config commit -m"

# vim stuff
alias vpy="echo -e '#!/usr/bin/env python3' | vim - +'file tmp.py'"
alias vsh="echo -e '#!/usr/bin/env bash' | vim - +'file tmp.sh'"

