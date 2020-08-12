function _pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

function _run() {
    if [ -e ~/.pure-bash-prompt ]; then
      if [ -e ~/gitstatus ]; then
        if [ -e /c/Program\ Files/Git/ ]; then
            cp -i ~/.pure-bash-prompt/bash.bashrc '/c/Program Files/Git/etc'
            cp -i ~/.pure-bash-prompt/.minttyrc ~
            cp -i ~/.pure-bash-prompt/.bash_profile ~
            cp -i ~/pure-bash-prompt/.git-completion.bash ~
            cp -i ~/pure-bash-prompt/.bash_aliases ~
	    cp -i ~/.pure-bash-prompt/gitbash.jpg ~
	    cp -i ~/.pure-bash-prompt/.bashrc ~
        else 
          echo "Install git before installing pure-bash-prompt, or make sure it is located in /c/Program Files; /c/Program\ Files/Git/ does not exist."
          _pause
		fi
      else 
        echo "Install gitstatus before installing pure-bash-prompt, or make sure it is located in ~; ~/gitstatus does not exist"
        _pause
      fi
    else
      echo "Clone the repository before installing pure-bash-prompt, or make sure it is located in ~; ~/pure_bash_prompt does not exist"
      _pause
    fi
}

net session > /dev/null 2>&1
if [ $? -eq 0 ]; then
  if [ ! -e ~/.bashrc ]; then
    echo "test -f ~/.bash_profile && . ~/.bash_profile">~/.bashrc
  else 
    echo "A ~/.bashrc exists; will be renamed to ~/.bashrc.backup."
    mv ~/.bashrc ~/.bashrc.backup
  fi
  _run
else
  echo "Run the script in an elevated bash prompt."
  _pause
fi
