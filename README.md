# pure-bash-prompt

An informative, non-overwhelming, clean, easy-to-change and quick alternative to the traditional Git-Bash for Windows prompt.

## Note:

I am aware of the lack-luster Windows prompts that are available in comparison to Linux and Mac systems. While it's certain that things like [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) will never be implemented for terminals such as Cygwin and GitBash, pure-bash-prompt seeks to emulate the most highly praised terminals in a Windows environment, while maintaining customizability.

## Screenshot

An example session would look as follows (click for better resolution). It displays the usage of aliases, prompt colors, git status symbols, and its color scheme.

![GitBash.PNG](https://github.com/ByNoMeans/pure-bash-prompt/blob/master/GitBash.PNG)

Run `psymbols` for more info.
   
## Inspiration

No code was explicitly taken from any of the following repos, but their prompts provided heavy inspiration to `pure-bash-prompt`'s themeing, symbols, and general format.

1. [Posh-Git](https://github.com/dahlbyk/posh-git/)
2. [Pure](https://github.com/sindresorhus/pure)
3. [Seafly](https://github.com/bluz71/bash-seafly-prompt/)
4. [Spaceship Prompt](https://github.com/denysdovhan/spaceship-prompt)

## Setup

1. **DO NOT USE CYGWIN! It contains unavoidable prompt-wrapping issues. Uninstall and remove it from your PATH.** 
2. Install [MinGW](https://sourceforge.net/projects/mingw/) and add `C:\Program Files\Git\bin` and `C:\MinGW\bin` to your PATH instead.
3. Install [Nodist](https://github.com/nullivex/nodist) to create NodeJS support. For me, tools like [nvm-for-windows](https://github.com/coreybutler/nvm-windows) couldn't even launch the console. 

## Installation

> :warning: **The mentioned files will be overwritten with the following commands. Your prompt will still ask you individually if you want to overwrite the files, but be cautious!**

> To have pure-bash-prompt continuously displaying an updated status with respect to the remote, consider creating a [Windows Task](https://en.wikipedia.org/wiki/Windows_Task_Scheduler) to automatically fetch from the remote every once and a while. View [here](https://bitbucket.org/blog/automate-git-commands-across-repos-using-batch-scripts-and-windows-scheduler) for inspiration, and make sure your repos are all inside one directory for ease of use.

#### In an ELEVATED BASH Terminal:

1. Backup your files
2. Install [gitstatus](https://github.com/romkatv/gitstatus)
```
git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/gitstatus && sed -i "$(($(wc -l <~/gitstatus/gitstatus.prompt.sh) - 20)),\$d" ~/gitstatus/gitstatus.prompt.sh
```
3. Clone the repository
```
git clone --depth=1 https://github.com/ByNoMeans/pure-bash-prompt ~/.pure-bash-prompt
```
4. Run the installation script (press `y + Enter` for any prompts to override files)
```
sh ~/.pure-bash-prompt/install_pure_bash_prompt.sh
```

## Aliases

Bash-Prompt offers simple, easy-to-remember aliases for:

1. Git
2. Virtual Environments
3. General Convenience

all of which are stored in the `.bash_aliases` file.

## Configuration

The "look" of the terminal is set in ~/.minttyrc. Alter font size, padding, and more from there.

256 ANSI Colors: [here](https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt). Very handy for customization.

Special characters: [here](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html). If you're someone who likes to see the time in military format, for example, you could append `\A` to your prompt.

Run `pgit`, `pvenv`, `phelp`, or `psymbols` to display more information about the aliases and prompt structure. Change the alias names and corresponding commands to your preference.

For example, running `psymbols` on an active Git-Bash terminal shows you the prompt structure of:
```
Prompt Symbols:

   ≠                   No upstream
   ✗                   No remote
   ↑                   Commits ahead
   ↓                   Commits behind
   ↕                   Diverged
   +                   Added
   -                   Deleted
   ~                   Modified
   %                   Untracked
   Ψ                   Unmerged

   Yellow: index status.
   Grey: working tree status.
   Blue indicates a problem or something you should update.
```
