function _set_directory() {
	PS1="%B%F{blue}%c "
}

function _set_git() {
  [ -d .git ] || return
	local sb=(${(@f)"$(gs -sb)"})
	(( ${#sb[@]} > 1 )) && local dirty="%F{241}*"
	sb="${sb[1]}"
	local br="%F{209}${${sb%%.*}##* }"
	if [[ "$sb" == *"..."* ]]; then 
	  local us="${${sb##*.}%% *}" up_down
	  us="%F{241}→%F{215}${us%%/*}%F{241}/%F{209}${us#*/} "
	  [[ "$sb" == *"ahead"* ]] && up_down='↑'
	  [[ "$sb" == *"behind"* ]] && up_down+='↓'
	  [ "$#up_down" == "2" ] && up_down='↕'
	  [ "$up_down" ] && us+="%F{red}$up_down "
	else 
	  br+=' '
	fi
	PS1+="$dirty$br$us"
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
  [ "$versions" ] && PS1+="%F{241}[${versions// /"%F{241},"}%F{241}] "
}

function _set_venv() {
  [[ "$VIRTUAL_ENV" ]] && PS1+="%F{241}(%F{215}$(basename $VIRTUAL_ENV)%F{241}) "
}

function precmd() {
  [[ $? -ne 0 ]] && pcolor="%F{red}" || pcolor="%F{206}"
  unset PS1 RPS1
  _set_directory
  _set_versions
  _set_git
  _set_venv
  PS1+="$pcolor❯%b "
  RPS1="%B%F{241}[%F{white}$(date +%H:%M)%F{241}]"
}
