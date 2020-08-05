# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# If started from sshd, make sure profile is sourced
if [[ -n "$SSH_CONNECTION" ]] && [[ "$PATH" != *:/usr/bin* ]]; then
  in_ssh_client="true"
  . /etc/profile
fi

# Warnings
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
        printf "\t\e[1;33mwarning:\e[0m\n%s\n\n" "${_warning}"
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

# Use MYSYS2_PS1 if set if no PS1 already exported.
# Default "user@host MSYSTEM current_dir" format
[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"
#if we have the "High Mandatory Level" group, it means we're elevated
#if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
#then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
#else _ps1_symbol='\$'
#fi

#Colors
#https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt

#Prompt "\something" customizations
#https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

function _parse_git_info() {

  # Shows branch, HEAD if not existing (Not the SHA! It's ugly!),
  # upstream, dirty, stash status

  git_info=""

  # Will be passed to _parse_git_bad; must be called before
  is_upstream=""

  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  git_info='\[\033[95;38;5;209m\]'"$branch"

  # Add "*" for dirty branch, "^" for existing stashes
  [ "$is_dirty" == "true" ] && git_info='\[\033[95;38;5;247m\]*'"$git_info"
  [[ $(git stash list) ]] && git_info='\[\033[95;38;5;247m\]^'"$git_info"

  upstream=$(git rev-parse --abbrev-ref "$branch"@{upstream} 2>/dev/null | head -n 1)

  if [ "$upstream" ]; then

    # Format: branch → upstream
    git_info+='\[\033[95;38;5;247m\] → \[\033[95;38;5;215m\]'"${upstream%/*}"'\[\033[95;38;5;247m\]/\[\033[95;38;5;209m\]'"${upstream##*/}"

    # Array parsing "<commitsAhead>           <commitsBehind>"
    commits=($(git rev-list --left-right --count "$branch"..."$upstream"))
    local up_down=""

    # If existing, add commits and a space before to format
    [ "${commits[0]}" != "0" ] && up_down+='↑'
    [ "${commits[1]}" != "0" ] && up_down+='↓'
    [ "$up_down" ] && up_down=' \[\033[95;38;5;110m\]'"$up_down"
    git_info+="$up_down"
  # Ignore standard GitFlow branches for "no upstream" symbol
  elif [ "$branch" != "support/support" ] && [ "$branch" != "hotfix/hotfix" ] && [ "$branch" != "bugfix/bugfix" ] && [ "$branch" != "release/release" ] && [ "$branch" != "feature/feature" ]; then
    is_upstream='≠'
  fi

  git_info+=' '
}

function _parse_git_bad() {
  git_bad=""

  # Display ✗ for no remotes, % for untracked files, and a space if either exist
  [[ ! $(git remote) ]] && git_bad+='✗'
  [ "$is_upstream" ] && git_bad+="$is_upstream"
  [ "$is_untracked" == "true" ] && git_bad+='%'
  [ "$git_bad" ] && git_bad='\[\033[95;38;5;110m\]'"$git_bad"' '
}

function _parse_git_status() {
  git_status=""

  # Will be passed to _parse_git_info; must be called before
  is_dirty=""
  is_dirty="false"

  # Will be passed to _parse_git_bad; must be called before
  is_untracked=""
  is_untracked="false"

  # Will contain "M", "D", "A", or "U"
  declare -a index_array=()
  declare -a working_array=()

  # index is reassigned later; don't include color
  # for cleaner if statement on line 184
  local index
  local working='\033[38;5;255m\]'

  # Parse output of git status -s:
  # <indexStatus><workingTreeStatus> <fileName>
  # <indexStatus><workingTreeStatus> <fileName>
  # ...
  while IFS= read -r line; do

    local index_status="${line::1}"
    # Only add values to index if array of index symbols so far doesn't
    # contain it, add it to the array to avoid future repetitions,
    # then convert to proper symbol
    if [[ ! " ${index_array[@]} " =~ " ${index_status} " ]] && [ "$index_status" != "0" ]; then
      index_array+=("$index_status")
      case $index_status in
      "A")
        index+='+'
        ;;
      "M")
        index+='~'
        ;;
      "D")
        index+='-'
        ;;
      "U")
        index+='Ψ'
        ;;
      "?")
        is_untracked="true"
        ;;
      esac
    fi

    # Same routine as above
    local working_status="${line:1:1}"
    if [[ ! " ${working_array[@]} " =~ " ${working_status} " ]] && [ "$working_status" != "0" ]; then
      working_array+=("$working_status")
      case $working_status in
      "A")
        working=+='+'
        ;;
      "M")
        working+='~'
        ;;
      "D")
        working+='-'
        ;;
      "U")
        working+='Ψ'
        ;;
      "?")
        is_untracked="true"
        ;;
      esac
    fi
  done < <(git status --porcelain)

  # Space if existing; "working" is the end of the
  # first prompt line, thus a space is unecessary
  [ "$index" ] && index='\033[38;5;218m\]'"$index"' '

  # Branch is dirty if ANY changes exist
  [ "${#working_array[@]}" -ne 0 ] || [ "${#index_array[@]}" -ne 0 ] && is_dirty="true"
  git_status="$index$working"
}

function _git_format() {
  git_string=""
  if [ -d .git ]; then
    # MAINTAIN ORDER OF CALLING!!!!!!!!!!!!!
    # Read function docs for more info
    _parse_git_status
    _parse_git_info
    _parse_git_bad
    git_string+="$git_info$git_bad$git_status"
  fi
}

function _set_ssh() {
  # Add user|host before venv and prompt symbol ("@" is ugly in Consolas)
  ssh_prompt=""
  [ "$in_ssh_client" == "true" ] && ssh_prompt='\[\033[95;38;5;240m\]\u\[\033[95;38;5;245m\]|\[\033[95;38;5;095m\]\h '
}

# To only trigger _set_venv function, as GitBash
# automatically adds venv for you if below enabled
export VIRTUAL_ENV_DISABLE_PROMPT=1

function _set_venv() {
  venv=""
  VIRT_ENV_TXT=""
  if [ "$VIRTUAL_ENV" != "" ]; then
    VIRT_ENV_TXT=$(basename \""$VIRTUAL_ENV")
  elif [ "$(basename \""$VIRTUAL_ENV"\")" = "__" ]; then
    VIRT_ENV_TXT=[$(basename \`dirname \""$VIRTUAL_ENV"\"\`)]
  fi
  [ "${VIRT_ENV_TXT}" != "" ] && venv='\[\033[95;38;5;245m\](\[\033[95;38;5;209m\]'"$VIRT_ENV_TXT"'\[\033[95;38;5;245m\]) '
}

function _set_prompt_symbol() {
  # Magenta/Pinkish on last command success, red otherwise
  prompt_symbol=""
  prompt_symbol="\$(if [ \$? = 0 ]; then echo \[\033[35m\]❯; else echo \[\033[31m\]❯; fi) "'\[\033[0m\]'
}

function _set_prompt() {
  PS1=""
  # Display COMPLETE pwd (I don't understand how you navigate without it)
  PS1+='\[\033]0;'"\007\]"'\n\[\033[95;38;5;121m\]\w '
  git_string=""
  _git_format
  _set_ssh
  _set_venv
  _set_prompt_symbol
  PS1+="$git_string\n$ssh_prompt$venv$prompt_symbol"
}

export PROMPT_COMMAND=_set_prompt

# Default from GitBash; don't honestly understand this
[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) == 'declare -x ' ]] ||
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
shopt -q login_shell
