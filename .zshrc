
function _set_directory() {
	directory="$(pwd)"
    storeCommand="\$(if [ "${directory:0:18}" == "/mnt/c/Users/barre" ]; then echo '#'${directory:18}; else echo "%~"; fi)"
	PS1+="%F{087}$storeCommand "
	unset directory storeCommand
}

function _set_git() {
    [[ -d .git ]] || return
	sb=(${(@f)"$(gs -sb)"})
	(( ${#sb[@]} > 1 )) && dirty="*"
	sb="${sb[1]}"
	branch="%F{209}${${sb##* }%%.*}"
	if [[ "$sb" == *"..."* ]]; then 
	  us="${${sb##*.}%% *}"
	  us="%F{247}→%F{215}${us%%/*}%F{247}/%F{209}${us#*/} "
	  [[ "$sb" == *"ahead"* ]] && up_down='↑'
	  [[ "$sb" == *"behind"* ]] && up_down+='↓'
	  [[ "$#up_down" == "2" ]] && up_down='↕'
	  [[ "$up_down" ]] && us+="%F{31}$up_down "
	else 
	  branch+=' '
	fi
	[[ "$dirty" ]] && branch="%F{247}$dirty$branch"
	PS1+="$branch$us"
	unset sb branch us dirty up_down
}

function _set_node() {
  #local node_symbol="⬢"
  [ -f package.json ] || [ -d node_modules ] || [ -f *.js ] || return;
  node_version=$(command node -v 2>/dev/null)
  [[ "$node_version" ]] && node_version="%F{121}${node_version/v} "
  PS1+="$node_version"
  unset node_version
}

function _set_venv() {
  [[ "$VIRTUAL_ENV" ]] && PS1+="%F{247}(%F{95}$(basename $VIRTUAL_ENV)%F{247}) "
}

function _set_PS1_symbol() {
    PS1_symbol="\$(if [ \$? = 0 ]; then echo %{%F{206%}❯; else echo %{%F{red%}❯; fi)%F{000} "
    PS1+="$PS1_symbol"
    unset PS1_symbol
}

function precmd() {
  unset PS1
  _set_directory
  _set_node
  _set_git
  _set_venv
  _set_PS1_symbol
}
