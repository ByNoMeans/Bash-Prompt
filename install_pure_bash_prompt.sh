function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

if [ ! -e ~/.bashrc ]; then
  if [ -e /c/cygwin/etc/bash.bashrc ]; then
    if [ -e ~/pure_bash_prompt ]; then
      if [ -e ~/gitstatus ]; then
        if [ -e /c/Program\ Files/Git/ ]; then
          if [ -e /c/cygwin/etc/nsswitch.conf ]; then
	    echo "db_home: /%H">>/c/cygwin/etc/nsswitch.conf
            cp -i ~/pure_bash_prompt/gitbash/bash.bashrc '/c/Program Files/Git/etc'
            cp -i ~/pure_bash_prompt/gitbash/.minttyrc ~
            cp -i ~/pure_bash_prompt/gitbash/.bash_profile ~
            cp -i ~/pure_bash_prompt/.git-completion.bash ~
            cp -i ~/pure_bash_prompt/gitbash/.bash_aliases ~
            cp -i ~/pure_bash_prompt/cygwin/bash.bashrc '/c/cygwin/etc'
          else
	    echo "Make sure cygwin is installed correctly. /c/cygwin/etc/nsswitch.conf does not exist."
	    pause
          fi
        else 
          echo "Install git before installing pure-bash-prompt, or make sure it is located in /c/Program Files; /c/Program\ Files/Git/ does not exist."
          pause
	fi
      else 
        echo "Install gitstatus before installing pure-bash-prompt, or make sure it is located in ~; ~/gitstatus does not exist"
        pause
      fi
    else
      echo "Clone the repository before installing pure-bash-prompt, or make sure it is located in ~; ~/pure_bash_prompt does not exist"
      pause
    fi
  else 
    echo "Install cygwin before installing pure-bash-prompt, or make sure it is located in /c/cygwin; /c/cygwin/etc/bash.bashrc does not exist."
    pause
  fi
else 
  echo "A ~/.bashrc exists; will be renamed to ~/.bashrc.backup", and a .bashrc with the correct contents will be made.
  mv ~/.bashrc ~/.bashrc.backup
  echo "test -f ~/.bash_profile && . ~/.bash_profile">~/.bashrc
  sh ~/pure-bash-prompt/install_pure_bash_prompt.sh
fi
