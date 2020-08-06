# pure-bash-prompt

An informative, non-overwhelming, clean, easy-tochange and fast alternative to the traditional Git-Bash for Windows prompt.

## Screenshot

An example session would look as follows. It displays the usage of aliases, prompt colors, git status suymbols, and its color scheme.

![GitBash.PNG](https://github.com/ByNoMeans/pure-bash-prompt/blob/master/GitBash.PNG)

## Inspiration

No code was explicitly taken from any of the following repos, but their prompts provided heavy inspiration to `pure-bash-prompt`'s themeing, symbols, and general format.

1. [Posh-Git](https://github.com/dahlbyk/posh-git/)
2. [Pure](https://github.com/sindresorhus/pure)
3. [Seafly](https://github.com/bluz71/bash-seafly-prompt/blob/master/command_prompt.bash)

## Installation

Install [gistatus](https://github.com/romkatv/gitstatus) to immensley speed up the rate the prompt appears. It is sourced within `.bash_profile` every open session to be used.

## Configuration

Set the Git-Bash configuration file (`~/.mintyrc`) to:

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
FontHeight=18
Scrollbar=none
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

Additionally, the git aliases use git-completion, so their usage would parallel exactly that of not using the alias in the first place.

## Tips

View [here](https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt) to get a complete description and explanation of ANSI colors, along with a complete graphic depicting all colors and their corresponding ANSI codes.

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
