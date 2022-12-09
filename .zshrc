
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# disable bell
unsetopt BEEP

# on WSL2, set a shortcut to the Windows user directory
# alias ~~="/mnt/c/Users/ESeng/"

# let WSL open the file explorer
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  export BROWSER='/mnt/c/Windows/explorer.exe'
  alias see='ranger' # use ranger for see
  alias open='explorer.exe .; return 0;' # open file dir
fi

# set the home directory in windows
export WIN_HOME='/mnt/c/Users/ESeng'

# set zsh prompt
zsh-os-check() {
  if [[ -n "$(uname -r | grep arch)" ]]; then
    psvar[2]=' ' # Arch
  elif [[ -n "$(uname -s | grep Darwin)" ]]; then
    psvar[2]='' # macos
  elif [[ -n "$(uname -s | grep Linux)" ]]; then
    psvar[2]='' # linux (Generic)
  else
    psvar[2]='' # windows
  fi
}

## git stuff
autoload -Uz vcs_info
precmd() {
  vcs_info
  zsh-os-check
}
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' use-simple false
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:git:*:-all-' command /usr/bin/git

## check for untracked changes
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
      hook_com[misc]=' ?'
  else
      hook_com[misc]=''
  fi
}

zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:*' formats " %F{229}%f %F{244}(%f%F{248}%b%f%F{244})%f%F{248}%m%u%c%f"
zstyle ':vcs_info:*' actionformats " %F{229}%f %F{244}(%f%F{248}%b|%a%f%F{244})%f%F{248}%m%u%c%f"

# colours selected from colours displayed from `spectrum_ls`
export PS1='%t %B%(?.%F{156}>%f.%F{202}>%f)%b %F{153}%2v %B%1~%b%f${vcs_info_msg_0_} ';
#               |                                 |     |      +- show git status
#               |                                 |     +- show the current working directory
#               |                                 +- set symbol showing which os is being used
#               +- show '>' prompt, coloured based off previous cmd's success/fail. (?.success_str.fail_str)
# reference: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

# set nvm stuff
export NVM_DIR="$HOME/.nvm"
if test -d $NVM_DIR ; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

export PATH="$PATH:$HOME/.local/bin"

export EDITOR=nvim

alias setenv='export $(cat .env | xargs)'
alias user_mount="function _(){sudo mount -o uid=1000,gid=1000 --mkdir $1 /media/usb};"
