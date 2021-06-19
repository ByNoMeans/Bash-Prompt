# Uncomment to use pure
#fpath=( "$HOME/.zfunc" $fpath )
#autoload -Uz promptinit; promptinit; prompt pure

export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export NVM_DIR="$HOME/.nvm" && . "/usr/local/opt/nvm/nvm.sh"
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export UPDATE_ZSH_DAYS=7

set bell-style none
set completion-ignore-case on
unset completealiases
setopt +o nomatch
unsetopt beep
bindkey '^H' backward-kill-word
bindkey '5~' kill-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
ZSH_THEME="dracula"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="mm/dd/yyyy"
DISABLE_MAGIC_FUNCTIONS="true"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

autoload -Uz compinit && compinit
autoload -U colors && colors

. ~/.zsh_aliases
. $ZSH/oh-my-zsh.sh

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash

function _set_directory() {
	PS1=$'\n'"%F{blue}%~ "
}

function _set_git() {
  [ -d .git ] || return
	local sb=(${(@f)"$(gs -sb)"})
	(( ${#sb[@]} > 1 )) && local dirty="%F{243}*"
	sb="${sb[1]}"
	local br="%F{209}${${sb%%.*}##* }"
  if [[ "$sb" == *"..."* ]]; then 
	  local us="${${sb##*.}%% *}" up_down
	  us="%F{243}→%F{215}${us%%/*}%F{243}/%F{209}${us#*/}"
	  [[ "$sb" == *"ahead"* ]] && up_down='↑'
	  [[ "$sb" == *"behind"* ]] && up_down+='↓'
	  [ "$#up_down" == "2" ] && up_down='↕'
	  [ "$up_down" ] && us+="%F{red} $up_down"
  elif [[ "$sb" == *"HEAD"* ]]; then
	  local br="%F{209}HEAD"
	fi
	PS1+="$dirty$br$us "
}

function _set_node() {
  [ -f package.json ] || [ -d node_modules ] || [ -f *.js ] || return;
  local node_version="$(node -v)"
  versions+="%F{green}${node_version/v}"
}

function _set_python() {
  [ -f *.py ] || return;
  local python_version="$(python3 --version)"
  versions+="%F{yellow}${python_version##* }"
}

function _set_java() {
  [ -f *.java ] || return;
  local java_version="$(javac --version)"
  versions+="%F{95}${java_version##* }"
}

function _set_versions() {
  local versions=()
  _set_node
  _set_python
  _set_java
  [ "$versions" ] && PS1+="%F{243}[${versions// /"%F{243},"}%F{243}]"
}

function _set_venv() {
  [ "$VIRTUAL_ENV" ] && PS1+="%F{243}(%F{215}$(basename $VIRTUAL_ENV)%F{243}) "
}

function precmd() {
  [[ $? -ne 0 ]] && pcolor="%F{red}" || pcolor="%F{206}"
  unset PS1 RPS1
  _set_directory
  _set_git
  _set_versions
  PS1+=$'\n'
  _set_venv
  _set_python
  PS1+="$pcolor❯%f "
  # Uncomment to add date in military time to right of prompt
  # RPS1="%B%F{243}[%F{white}$(date +%H:%M)%F{243}]"
}
