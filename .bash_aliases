alias tree='cmd //c tree //f'
alias setreq='pip3 freeze > requirements.txt' 

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
alias gf='git fetch'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset" --abbrev-commit --date=relative --all'
alias gmv='git mv'
alias gpll='git pull'
alias gpu='git push'
alias grbs='git rebase'
alias grem='git remote'
alias gres='git reset'
alias grm='git rm'
alias gs='git status'
alias gt='git tag'

alias gitaliases="echo $'
These are the aliases contained within your custom prompt bash.bashrc file:

Git aliases:
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
   gf             git fetch
   glog           git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset\" --abbrev-commit --date=relative --all
   gmv            git mv
   gpll           git pull
   gpu            gut push
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
   
alias promptsymbols="echo $'
These are the symbols within the git prompt:
   
   First \"[]\"          Index status
   Second \"[]\"         Working tree status
   {}                  Empty repository
   ✗                   No remote
   ≠                   No upstream
   ↑                   # Commits ahead
   ↓                   # Commits behind
   Ψ                   Unmerged files
   
   A orange color indicates the index status.
   An grey color indicates the working tree status.
   A red color indicates a problem.'"