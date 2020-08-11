# pure-bash-prompt

An informative, non-overwhelming, clean, easy-to-change and quick alternative to the traditional Git-Bash for Windows prompt.

## Note:

I am aware of the lack-luster Windows prompts that are available in comparison to Linux and Mac systems. While it's certain that things like [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) will never be implemented for terminals such as cygwin and GitBash, pure-bash-prompt seeks to emulate the most highly praised terminals in a Windows environment, while maintaining customizability. The latter, along with inspired implementation with respect to the great [Spaceship Prompt](https://github.com/denysdovhan/spaceship-prompt) are currently being worked on.

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

## Layout

The terminal prompt takes the following form in each session: 

```
<nonAbsoluteDirectory> <gitInfo>
<SSH-info> <virtualenvInfo> <promptSymbol>
```

Within a git repository, not ssh-ed in, and without a virtualenv, the terminal format would be as follows: 

```
<nonAbsoluteDirectory> <ifBranchDirty><ifStashes><branchName> <upstream> <ifRemote><ifUpstream><untracked> <added><modified><deleted><unmerged>
<promptSymbol>
```

## Aliases

Bash-Prompt offers simple, easy-to-remember aliases for:

1. Git
2. Git Flow
3. Virtual Environments
4. General Convenience

all of which are stored in the `.bash_aliases` file.

Additionally, the git aliases use git-completion; tabs works like always.

## Tips

Set cursor to "line" and "blinking" if you're not a traditional "block" or  "underscore" type of person.

View [here](https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt) to get a complete description and explanation of ANSI colors, along with a complete graphic depicting all colors and their corresponding ANSI codes (very handy if you wish to customize).

View [here](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html) to see all backslash-escaped characters. For example, `\W` provides the absolute current working directory, and `\A` provides the time (to the minute) expressed in military time.

Run `pgit`, `pvenv`, `phelp`, or `psymbols` to display more information about the aliases and prompt structure. Change the alias names and corresponding commands to your preference.

For example, running `psymbols` on an active Git-Bash terminal shows you the prompt structure of:
```
Prompt Symbols:

   ≠                   No upstream
   ✗                   No remote
   ↑                   Commits ahead
   ↓                   Commits behind
   +                   Added
   -                   Deleted
   ~                   Modified
   %                   Untracked
   Ψ                   Unmerged

   Yellow: index status.
   Grey: working tree status.
   Blue indicates a problem or something you should update.
```
