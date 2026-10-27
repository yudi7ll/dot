POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.config/oh-my-zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git encode64 sudo fzf safe-paste docker colored-man-pages extract universalarchive urltools aliases gitignore systemd z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Kitty Terminal
if command -v kitty &>/dev/null; then
  # Completion for kitty
  kitty + complete setup zsh | source /dev/stdin
fi

# ignore all duplicated history
setopt HIST_IGNORE_ALL_DUPS

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export TERM=xterm-256color
else
  export EDITOR='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Compilation flags
if [[ "$(uname -m)" == "arm64" ]]; then
  export ARCHFLAGS="-arch arm64"
else
  export ARCHFLAGS="-arch x86_64"
fi

# profile
PROFILE=$HOME/.config/zsh/profile.zsh
[[ -f $PROFILE ]] && source $PROFILE

# alias
ALIASES=$HOME/.config/zsh/aliases.zsh
[[ -f $ALIASES ]] && source $ALIASES

# functions
FUNCTIONS=$HOME/.config/zsh/functions.zsh
[[ -f $FUNCTIONS ]] && source $FUNCTIONS

# OS detection
if [[ "$(uname)" == "Darwin" ]]; then
  export PLATFORM="macos"
elif [[ "$(uname)" == "Linux" ]]; then
  export PLATFORM="linux"
fi

if [[ -f ~/.zshenv ]]; then
  source ~/.zshenv
fi

# workaround for neovim crash: too many open files
# ulimit -n 10240

# nvm
NVM=/usr/share/nvm/init-nvm.sh
[[ -f $NVM ]] && source /usr/share/nvm/init-nvm.sh

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init - zsh)"
fi

# Add .NET Core SDK tools
export PATH="$HOME/.dotnet/tools:$PATH"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/yudi/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Claude Code: Auto-switch between APIs based on directory
# claude() {
#   local use_wallex=true
#   local args=()

#   for arg in "$@"; do
#     if [[ "$arg" == "--no-wallex" ]]; then
#       use_wallex=false
#     else
#       args+=("$arg")
#     fi
#   done

#   if [[ "$PWD" == *[Ww]allex* && "$use_wallex" == true ]]; then
#     echo "--- Wallex API Activated ---"
#     command claude --settings ~/.claude/settings.wallex.json "${args[@]}"
#   else
#     echo "--- OpenRouter API Activated ---"
#     command claude "${args[@]}"
#   fi
# }
export PATH="/home/yudi/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/yudi/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# Added by Antigravity CLI installer
export PATH="/home/yudi/.local/bin:$PATH"

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
