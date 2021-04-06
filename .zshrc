function _set_directory() {
	local dir="$(pwd)"
    dir="\$(if [ "${dir:0:18}" == "/mnt/c/Users/barre" ]; then echo '#'${dir:18}; else echo "%c"; fi)"
	PS1="%B$fg[blue]$dir "
}

function _set_git() {
    [[ -d .git ]] || return
	local sb=(${(@f)"$(gs -sb)"})
	(( ${#sb[@]} > 1 )) && local dirty="*"
	sb="${sb[1]}"
	local br="%F{209}${${sb%%.*}##* }"
	if [[ "$sb" == *"..."* ]]; then 
	  local us="${${sb##*.}%% *}"
	  us="$fg[black]→%F{215}${us%%/*}$fg[black]/%F{209}${us#*/} "
	  [[ "$sb" == *"ahead"* ]] && local up_down='↑'
	  [[ "$sb" == *"behind"* ]] && up_down+='↓'
	  [[ "$#up_down" == "2" ]] && up_down='↕'
	  [[ "$up_down" ]] && us+="$fg[red]$up_down "
	else 
	  br+=' '
	fi
	[[ "$dirty" ]] && br="$fg[black]$dirty$br"
	PS1+="$br$us"
}

function _set_node() {
  [ -f package.json ] || [ -d node_modules ] || [ -f *.js ] || return;
  local node_version="$(node -v)"
  [[ "$node_version" ]] && versions+="$fg[green]${node_version/v}"
}

function _set_python() {
  [ -f *.py ] || return;
  local python_version="$(python3 --version)"
  [[ "$python_version" ]] && versions+="$fg[yellow]${python_version##* }"
}

function _set_java() {
  [ -f *.java ] || return;
  local java_version="$(javac --version)"
  [[ "$java_version" ]] && versions+="%F{95}${java_version##* }"
}

function _set_versions() {
  local versions=()
  _set_node
  _set_python
  _set_java
  [[ "$versions" ]] && PS1+="$fg[black][${versions// /$fg[black],}$fg[black]] "
}

function _set_venv() {
  [[ "$VIRTUAL_ENV" ]] && PS1+="$fg[black](%F{215}$(basename $VIRTUAL_ENV)$fg[black]) "
}

function precmd() {
  [[ $? -ne 0 ]] && pcolor="$fg[red]" || pcolor="%F{206}"
  unset PS1
  _set_directory
  _set_versions
  _set_git
  _set_venv
  PS1+="$pcolor❯%b "
}
