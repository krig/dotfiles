# Setup homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

ulimit -n 4096

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ -f "/opt/homebrew/opt/llvm/bin/lldb-vscode" ]; then
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
fi
export PATH="$HOME/bin:$HOME/.emacs.d/bin:$HOME/.cargo/bin:$PATH"

if [ -d "$HOME/Library/Python/3.9/bin" ]; then
    export PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi

# Path to your oh-my-zsh installation.
if [ -d $HOME/src/oh-my-zsh ]; then
    export ZSH="$HOME/src/oh-my-zsh"
else
    export ZSH="/Users/krig/.oh-my-zsh"
fi

export AUTOSSH_PORT=0

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

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
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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

export NAME="Kristoffer Grönlund"
export EMAIL="kristoffer.gronlund@netinsight.net"
export EDITOR="nvim"

alias s="kitty +kitten ssh"

if [ "$(command -v exa)" ]; then
    unalias -m 'll'
    unalias -m 'l'
    unalias -m 'la'
    unalias -m 'ls'
    alias ls='exa -G  --color auto -a -s type'
    alias ll='exa -l --color always -a -s type'
elif [ "$(command -v lsd)" ]; then
    unalias -m 'll'
    unalias -m 'la'
    unalias -m 'ls'
    alias ls='lsd'
    alias ll='lsd -l'
    alias la='lsd -a'
fi

if [ "$(command -v nvim)" ]; then
    alias vim='nvim'
    alias vi='nvim'
    alias e='nvim'
elif [ "$(command -v hx)" ]; then
    alias e='hx'
fi

alias ec="emacsclient -n -a emacs"
alias g="git"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.config/broot/launcher/bash/br


export QMK_HOME="$HOME/src/qmk_firmware"

eval "$(zoxide init zsh)"

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
	source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh

    find_file() {
        vterm_cmd find-file "$(realpath "${@:-.}")"
    }

    say() {
        vterm_cmd message "%s" "$*"
    }
fi

[[ "$INSIDE_EMACS" = 'vterm' ]] || eval "$(starship init zsh)"


function git {
  # Only touch git if it's the push subcommand
  if [[ "$1" == "push" ]]; then
    force=false
    override=false

    for param in "$@"; do
      if [[ $param == "--force" ]]; then force=true; fi
      if [[ $param == "--seriously" ]]; then override=true; fi
    done

    # If we're using --force but not --seriously, change it to --force-with-lease
    if [[ "$force" = true && "$override" = false ]]; then
      echo -e "\033[0;33mDetected use of --force! Using --force-with-lease instead. If you're absolutely sure you can override with --force --seriously.\033[0m"

      # Unset --force
      for param; do
        [[ "$param" = --force ]] || set -- "$@" "$param"; shift
      done

      # Replace it with --force-with-lease
      set -- "push" "$@" "--force-with-lease"; shift
    else
      if [[ "$override" = true ]]; then
        echo -e "\033[0;33mHeads up! Using --force and not --force-with-lease.\033[0m"
      fi

      # Unset --seriously or git will yell at us
      for param; do
        [[ "$param" = --seriously ]] || set -- "$@" "$param"; shift
      done
    fi
  fi

  command git "$@"
}


source /Users/krigro/.config/broot/launcher/bash/br
