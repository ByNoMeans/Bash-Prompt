([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

[[ "$-" != *i* ]] && return

[[ -n "$SSH_CONNECTION" ]] && in_ssh_client="true"

unset _warning_found
for _warning_prefix in '' ${MINGW_PREFIX}; do
  for _warning_file in "${_warning_prefix}"/etc/profile.d/*.warning{.once,}; do
    test -f "${_warning_file}" || continue
    _warning="$(command sed 's/^/\t\t/' "${_warning_file}" 2>/dev/null)"
    if test -n "${_warning}"; then
      if test -z "${_warning_found}"; then
        _warning_found='true'
        echo
      fi
      if test -t 1; then
        printf "\t\033[1;33mwarning:\033[0m\n%s\n\n" "${_warning}"
      else
        printf "\twarning:\n%s\n\n" "${_warning}"
      fi
    fi
    [[ "${_warning_file}" == *.once ]] && rm -f "${_warning_file}"
  done
done
unset _warning_found
unset _warning_prefix
unset _warning_file
unset _warning

[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"

function _git_if_dirty() {
  local is_dirty=""
  test -z "$(git status --porcelain)" || is_dirty="\[\033[31m\]*"
}

function _parse_git_status() {
  git_status=""
  up_down=""
  declare -a index_array=()
  declare -a working_array=()
  local index=""
  local working=""
  local count="0"
  while IFS= read -r line; do
    if [ "$count" == "0" ]; then
		count="1"
		[[ $line == *"ahead"* ]] && up_down+="↑"
		[[ $line == *"behind"* ]] && up_down+="↓"
		[ "${#up_down}" == "2" ] && up_down='↕'
	fi
    local index_status="${line::1}"
    if [[ ! " ${index_array[@]} " =~ " ${index_status} " ]] && [ "$index_status" != "0" ]; then
      index_array+=("$index_status")
      case $index_status in
      "?")
        index+='%'
        ;;
	  "A")
        index+='+'
        ;;
      "M")
        index+='~'
        ;;
      "D")
        index+='-'
        ;;
      "R")
        index+='≇'
		;;
      "U")
        index+='Ψ'
        ;;
      "C")
        index+='#'
        ;;
      esac
    fi
    local working_status="${line:1:1}"
    if [[ ! " ${working_array[@]} " =~ " ${working_status} " ]] && [ "$working_status" != "0" ]; then
      working_array+=("$working_status")
      case $working_status in
      "?")
        working+='%'
        ;;
	  "A")
        working=+='+'
        ;;
      "M")
        working+='~'
        ;;
      "D")
        working+='-'
        ;;
      "R")
	    working+='≇'
	    ;;
      "U")
        working+='Ψ'
        ;;
      "C")
	working+='#'
	;;
      esac
    fi
  done < <(git status --porcelain -b)
  [ "$index" ] && index='\[\033[95;38;5;63m\]'"$index "
  [ "$working" ] && working='\[\033[38;5;206m\]'"$working "
  git_status+="$index$working"
}

function _parse_git_info() {
  git_info=""
  is_upstream=""
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  git_info='\[\033[95;38;5;209m\]'"$branch"
  [[ $(git stash list) ]] && git_info='\[\033[95;38;5;247m\]^'"$git_info"
  [[ $(git status --porcelain) ]] && git_info='\[\033[95;38;5;247m\]*'"$git_info"
  upstream=$(git rev-parse --abbrev-ref "$branch"@{upstream} 2>/dev/null | head -n 1)
  if [ "$upstream" ]; then
    git_info+='\[\033[95;38;5;247m\]→\[\033[95;38;5;215m\]'"${upstream%/*}"'\[\033[95;38;5;247m\]/\[\033[95;38;5;209m\]'"${upstream##*/} "
    [ "$up_down" ] && git_info+='\[\033[31m\]'"$up_down "
  else 
    git_info+=' '
  fi
}

function _set_git() {
  git_string=""
  if [ -d .git ]; then
    _parse_git_status
    _parse_git_info
    git_string+="$git_info$git_status"
  fi
}



function _set_ssh() {
  ssh_prompt=""
  # Temp string for when down: "\[\033[95;38;5;131m\]127.0.0.1\[\033[95;38;5;247m\]::\[\033[95;38;5;095m\]22 "
  [[ "$in_ssh_client" == "true" ]] && ssh_prompt='\[\033[95;38;5;131m\]'"${SSH_CLIENT%% *}"'\[\033[95;38;5;247m\]::\[\033[95;38;5;095m\]'"${SSH_CLIENT##* }"
}

function _set_venv() {
  venv=""
  VIRT_ENV_TXT=""
  if [ "$VIRTUAL_ENV" != "" ]; then
    VIRT_ENV_TXT=$(basename \""$VIRTUAL_ENV")
  elif [ "$(basename \""$VIRTUAL_ENV"\")" = "__" ]; then
    VIRT_ENV_TXT=[$(basename \`dirname \""$VIRTUAL_ENV"\"\`)]
  fi
  [[ "${VIRT_ENV_TXT}" != "" ]] && venv='\[\033[95;38;5;247m\](\[\033[95;38;5;209m\]'"$VIRT_ENV_TXT"'\[\033[95;38;5;247m\]) ' 
}

function _set_node() {
  local node_symbol="⬢"
  node_version=""
  [ -f package.json ] || [ -d node_modules ] || [ -f *.js ] || return;
  node_version=$(command node -v 2>/dev/null)
  [ "$node_version" ] && node_version='\[\033[95;38;5;121m\]'"${node_version/v} "
}

function _set_prompt_symbol() {
  prompt_symbol=""
  tmp_ss=""
  prompt_symbol="\$(if [ \$? = 0 ]; then echo \[\033[35m\]❯; else echo \[\033[31m\]❯; fi) "'\[\033[0m\]'
}

function _set_prompt() {
  local verbose_prompt="false"
  PS1=""
  PS1="\[\033]0;$PWD\007\]"'\[\033[36m\]'
  if [ "$verbose_prompt" == "true" ]; then
	PS1+='\n\w '
    git_string+="\n"
  else
	PS1+='\W '
  fi
  _set_git
  _set_venv
  _set_node
  _set_ssh
  _set_prompt_symbol
  PS1+="$node_version$git_string$ssh_prompt$venv$prompt_symbol"
}

export PROMPT_COMMAND=_set_prompt

[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) == 'declare -x ' ]] ||
  export PS1='\[\033]0;\w\a\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM\[\033[0m\] \[\033[33m\]\w\[\033[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol

shopt -q login_shell