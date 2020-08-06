# pure-bash-prompt

An informative, non-overwhelming, clean, easy-to-change and fast alternative to the traditional Git-Bash for Windows prompt.

## Screenshot

An example session would look as follows. It displays the usage of aliases, prompt colors, git status suymbols, and its color scheme.

![GitBash.PNG](https://github.com/ByNoMeans/pure-bash-prompt/blob/master/GitBash.PNG)

## Layout

The terminal prompt takes the following form in each terminal: 

```
<nonAbsoluteDirectory> <gitInfo>
<SSH-info> <virtualenvInfo> <promptSymbol>
```

Within a git repository, not ssh-ed in, and without a virtualenv, the terminal format would be as follows: 

```
<nonAbsoluteDirectory> <ifBranchDirty><branchName> <upstream> <symbols>
<promptSymbol>
```
   
## Inspiration

No code was explicitly taken from any of the following repos, but their prompts provided heavy inspiration to `bash-prompt`'s themeing, symbols, and general format.

1. [Posh-Git](https://github.com/dahlbyk/posh-git/)
2. [Pure](https://github.com/sindresorhus/pure)
3. [Seafly](https://github.com/bluz71/bash-seafly-prompt/blob/master/command_prompt.bash)

## Installation

There is always a gigantic variation in the location of people's files with respect to terminals. No installation script is provided, as I would prefer you to be given the maximum control. If you are one of those people, execute the following commands but with respect to your proper file locations.

1. Clone the repository
```
git clone --depth 1 https://github.com/ByNoMeans/pure-bash-prompt ~/.pure_bash_prompt
```
2. Copy `bash.bashrc` or `bash-documented.bashrc` to /Git/etc/. If you prefer documentation and chose the latter, make sure to rename it to `bash.bashrc`
```
mv ~/.pure_bash_prompt/bash.bashrc /c/Program\ Files/Git/etc
```
3. Copy `.bash_profile`, `.git-completion.bash`, `.bash_aliases`, and `.bashrc` to ~
```
cp -i ~/.pure_bash_prompt/.bash_profile ~ && cp -i ~/.pure_bash_prompt/.git-completion.bash ~ && cp -i ~/.pure_bash_prompt/.bash_aliases ~ && cp -i ~/.pure_bash_prompt/.bashrc ~
```
4. Install [gistatus](https://github.com/romkatv/gitstatus) to immensley speed up the rate the prompt appears. It is sourced within `.bash_profile` at the beginning of each session to be used, so you don't need to run the second command of the repo's instructions. Just run
```
git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/gitstatus

```

## Configuration

Set the Git-Bash configuration file (`~/.minttyrc`) to:

```
ThemeFile=dracula
FontSmoothing=default
CtrlShiftShortcuts=yes
Locale=C
Charset=UTF-8
ClicksPlaceCursor=yes
BackgroundColour=40,42,54
ForegroundColour=40,42,54
Font=Consolas
```

Set cursor to "line" and "blinking" if you're not a traditional "block" or  "underscore" type of person.

Set scrollbar to "none" in "Window" for that extra minimal look.

## Aliases

Bash-Prompt offers simple, easy-to-remember aliases for:

1. Git
2. Git Flow
3. Virtual Environments
4. General Convenience

all of which are stored in the `.bash_aliases` file.

Additionally, the git aliases use git-completion, tab works like always.

## Tips

View [here](https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt) to get a complete description and explanation of ANSI colors, along with a complete graphic depicting all colors and their corresponding ANSI codes (very handy if you wish to customize).

View [here](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html) to see all backslash-escaped characters. For example, `\W` provides the absolute current working directory, and `\A` provides the time (to the minute) expressed in military time.

Run `pgit`, `pvenv`, `phelp`, or `psymbols` to display more information about the aliases and prompt structure. Change the alias names and corresponding commands to your preference.

For example, running `psypmbols` on an active Git-Bash terminal shows you the prompt structure of:
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
