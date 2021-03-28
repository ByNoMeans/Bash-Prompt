export ZSH="/home/barrxt/.oh-my-zsh"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
LS_COLORS=$LS_COLORS:'ow=01;34:'; export LS_COLORS

unset completealiases
setopt +o nomatch
unsetopt beep

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

autoload -Uz compinit && compinit
autoload -U colors && colors

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

. ~/.aliases
. $ZSH/oh-my-zsh.sh

bindkey '^H' backward-kill-word
bindkey '5~' kill-word
