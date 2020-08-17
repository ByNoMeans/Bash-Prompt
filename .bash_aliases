test -f ~/.git-completion.bash && . ~/.git-completion.bash

alias phelp="echo $'
Run the following commands to help understand the prompt:
   bpfast             Convenience methods
   bpgit              Git aliases
   bpvenv             Virtualenv aliases
   bpsymbols          Prompt symbols
'"

function _cd_up() { cd $(printf "%0.s../" $(seq 1 $1 )); }
alias cd..='_cd_up'

alias cls='clear'

function _compile_cpp() {
  filename=""
  version=""
  [ -f a.exe ] && rm -rf a
  if [ -n "$1" ]; then
    if [ -n "$2" ]; then
		version="$1"
		filename="$2"
	else
		version="17"
		filename="$1"
	fi
	[ "${filename: -4}" != ".cpp" ] && [ -f "$filename.cpp" ] && filename+=".cpp"
	[ -f "$filename" ] && g++ -fdiagnostics-color -std=c++$version "$filename" -o a || g++ -fdiagnostics-color
	[ -f a.exe ] && ./a && rm -rf a
  fi
}
alias crun='_compile_cpp'

alias installreq='pip3 install -r requirements.txt'
alias setreq='pip3 freeze > requirements.txt'

alias src='source'
alias srcalias='. ~/.bash_aliases'
alias srcprof='. ~/.bash_profile'
alias srcrc='. /c/Program\ Files/Git/etc/bash.bashrc'

alias valias='vim ~/.bash_aliases'
alias vprof='vim ~/.bash_profile'
alias vrc='vim /c/Program\ Files/Git/etc/bash.bashrc'


function _set_irb() {
  test -f "$(which irb).cmd" && winpty "$(which irb).cmd" && return 0;
  test -f "$(which irb).bat" && winpty "$(which irb).bat" && return 0;
}
alias irb='_set_irb'

alias la='ls -la'

function _mk_cd() { mkdir "$1"; cd "$1"; }
alias mkcd='_mk_cd'

alias open='start'
alias rmf='rm -rf'

function _ssh_bash() {
	if [ -n "$1" ]; then
		[ -n "$2" ] && ssh -t "$1"@"$2" \"bash -l\" || ssh -t $(whoami)@"$1" \"bash -l\"
	else
		ssh -t $(whoami)@localhost \"bash -l\"
	fi
}
alias sshb='_ssh_bash'

function _tree() { [ -n "$1" ] && [ "$1" == "f" ] && cmd //c tree //f || cmd //c tree; }
alias tree='_tree'

alias pfast="echo $'
   irb                Ruby terminal
   cd.. <integer>     Moves back <integer> directories
   cls                Clear screen
   crun               Compile c++ files: g++ <version> (optional) filename (.cpp optional)
   installreq         Installs requirements.txt
   mkcd               Create, cd into directory
   open               Same as \"start\"
   rmf                Force remove
   setreq             Sets installation requirements to file
   srcalias           Source ~/.bash_aliases
   srcprof            Source ~/.bash_profile
   srcrc              Source Git/etc/bash.bashrc
   valias             Vim ~/.bash_aliases
   vprof              Vim ~/.bash_profile
   vrc                Vim /Git/etc/bash.bashrc
   tree               Print directory structure (/f to include files)'"


alias ga='git add'
__git_complete ga _git_add
alias gb='git branch'
__git_complete gb _git_branch
alias gch='git checkout'
__git_complete gch _git_checkout
alias gcm='git commit'
__git_complete gcm _git_commit
alias gcmm='git commit -m'
alias gcl='git clone'
__git_complete gcl _git_clone
alias gcp='git cherry-pick'
__git_complete gcp _git_cherry_pick
alias gd='git diff'
__git_complete gd _git_diff
alias gf='git flow'
alias gfch='git fetch'
__git_complete gfch _git_fetch
alias ggraph='git log --graph --abbrev-commit --date=relative --all'
alias glog='git log'
__git_complete glog _git_log
alias gplog="git log --pretty=format:'%h   %an   %s' -5"
alias gmrg='git merge'
__git_complete gmrg _git_merge
alias gp='git pull'
__git_complete gp _git_pull
alias gpu='git push'
__git_complete gpu _git_push
alias grbs='git rebase'
__git_complete grbs _git_rebase
alias grem='git remote'
__git_complete grem _git_remote
alias gres='git reset'
alias grm='git rm'
__git_complete grm _git_rm
__git_complete gres _git_reset
alias gs='git status'
__git_complete gs _git_status
alias gst='git stash'
__git_complete gst _git_stash
alias gt='git tag'
__git_complete gt _git_tag

alias pgit="echo $'
   ga             add
   gb             branch
   gch            checkout
   gcm            commit
   gcl            clone
   gcp            cherry-pick
   gd             diff
   gf             flow
   gfch           fetch
   ggraph         Commit-abbreviated, relative-dated graph
   glog           log
   gplog          <hash>   <user>   <description>
   gmrg           merge
   gp             pull
   gpu            push
   grbs           rebase
   grem           remote
   gres           reset
   grm            remove
   gs             status
   gst            stash
   gt             tag'"

function _mkvenv() { [ -n "$1" ] && virtualenv "$1" || virtualenv venv; }
alias mkvenv='_mkvenv'

function _rmvenv() {
	[[ $(type deactivate 2>/dev/null) ]] && deactivate
	if [ -n "$1" ]; then
	 	rmf "$1"
	else
		rmf venv
	fi
}
alias rmvenv='_rmvenv'

function _srcvenv() { [ -n "$1" ] && . "$1"/Scripts/activate || . venv/Scripts/activate; }
alias srcvenv='_srcvenv'

function _setvenv() {
	if [ -n "$1" ]; then
		mkvenv "$1" && srcvenv "$1"
	else
		mkvenv && srcvenv
	fi
}
alias setvenv='_setvenv'

alias pvenv="echo $'
Virtual Environment aliases (include name if not \"venv\"):
   mkvenv         Create venv
   rmvenv         Remove venv
   setvenv        Create, source venv
   srcvenv        Source venv'"

alias psymbols="echo $'
Prompt Symbols:
   ≠                   No upstream
   ✗                   No remote
   ↑                   Commits ahead
   ↓                   Commits behind
   ↕                   Diverged
   +                   Added
   -                   Deleted
   ~                   Modified
   $                   Renamed
   #                   Copied
   %                   Untracked
   Ψ                   Unmerged
   Pink: index status.
   Grey: working tree status.
   Blue: a problem or something you should update.'"
