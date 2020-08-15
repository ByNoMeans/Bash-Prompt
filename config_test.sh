test -f ~/pure-bash-prompt.config || touch ~/pure-bash-prompt.config

configurations=("NODE" "PYTHON" "RUBY")

alias pconf='_set_config_var'
# Add srcconf and edit aliases, make sure this file is sourced correctly

function _set_config_var() {
	[ -z "$1" ] && echo "Provide a variable to alter." && exit
	input_var="${1^^}"
	if [[ " ${configurations[@]} " =~ " $input_var " ]]; then
		if [ -n "$2" ] && [[ $2 =~ ^[0-1]+$ ]]; then
			sed -i "/$input_var/d" ~/pure-bash-prompt.config
			echo "SHOW_$input_var=$2" >> ~/pure-bash-prompt.config
			_prompt_edit_config
		elif [[ ! $1 =~ ^[0-1]+$ ]]; then
			echo "Value must be a number between 0 and 1."
		elif [ -z "$2" ]; then
			echo "No integer provided to alter variable."
		fi
	elif [[ ! " ${configurations[@]} " =~ " $input_var " ]]; then
		echo "Variable must be in the list of configurations:"
		join_by ", " "${configurations[@]}"
	fi
}

function _prompt_edit_config() {
	echo "This is your config file."
	echo
	cat ~/pure-bash-prompt.config
	echo
	while true; do
		read -p "Edit? (y/n) " response
		case $response in
			[Yy]* ) vim ~/pure-bash-prompt.config; break;;
			[Nn]* ) break;;
			* ) echo "Please answer yes or no.";;
		esac
	done
}

function join_by { local IFS="$1"; shift; echo "$*"; }
