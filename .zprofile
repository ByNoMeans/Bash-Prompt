export ZSH=$HOME/.oh-my-zsh
export PATH="/usr/local/bin:$PATH"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LS_COLORS=$LS_COLORS:'ow=01;34:'
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
. "$NVM_DIR/bash_completion"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

set bell-style none
set completion-ignore-case on
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
unsetopt beep
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="mm/dd/yyyy"
unset completealiases
setopt +o nomatch

autoload -Uz compinit && compinit
autoload -U colors && colors

. ~/.aliases
. $ZSH/oh-my-zsh.sh

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
