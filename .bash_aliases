function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias cd..='cd_up'
alias cls='clear'
alias installreq='pip3 install -r requirements.txt'
alias setreq='pip3 freeze > requirements.txt' 
alias tree='cmd //c tree //f'
alias convenience="echo $'
   cd.. <integer>     Moves current directory <integer> levels up
   installreq         Installs requirements (only run in a virtualenv)
   setreq             Sets installation requirements
   tree               Prints directory structure (delete /f to remove files)'"

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gblm='git blame'
alias gcfg='git config'
alias gch='git checkout'
alias gcm='git commit'
alias gcl='git clone'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gf='git flow'
alias gfch='git fetch'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset" --abbrev-commit --date=relative --all'
alias gmv='git mv'
alias gpsh='git push'
alias gpu='git pull'
alias grbs='git rebase'
alias grem='git remote'
alias gres='git reset'
alias grm='git rm'
alias gs='git status'
alias gt='git tag'

alias gitaliases="echo $'
   g              git
   ga             git add
   gb             git branch
   gblm           git blame
   gcfg           git config
   gch            git checkout
   gcm            git commit
   gcl            git clone
   gcp            git cherry-pick
   gd             git diff
   gf             git flow
   gfch           git fetch
   glog           git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset\" --abbrev-commit --date=relative --all
   gmv            git mv
   gpsh           gut push
   gpu            git pull
   grbs           git rebase
   grem           git remote
   gres           git reset  
   grm            git rm
   grem           git remote
   gs             git status
   gt             git tag'"

alias delvenv='deactivate venv && rm -rf venv'
alias setvenv='virtualenv venv && source venv/Scripts/activate'
alias sourcevenv='source venv/Scripts/activate'
alias venvaliases="echo $'
Virtual Environment aliases:
   delvenv        deactivate venv && rm -rf venv
   setvenv        virtualenv venv && source '\''venv/Scripts/activate'\'$'
   sourcevenv     source '\''venv/Scripts/activate'\'"
   
alias symbols="echo $'
   
   First \"[]\"        Index status
   Second \"[]\"       Working tree status
   {}                  Empty repository
   ✗                   No remote
   ≠                   No upstream
   ↑                   Commits ahead
   ↓                   Commits behind
   +                   Added files
   -                   Deleted files
   ~                   Modified files
   ?                   Untracked files
   Ψ                   Unmerged files
   
   Orange indicates index status.
   Grey indicates working tree status.
   White indicates a problem or something you should update.'"