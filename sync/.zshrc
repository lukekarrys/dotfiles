ZSH_DISABLE_COMPFIX=true
export DEFAULT_USER="lukekarrys"

export PROJECT_DIR="$HOME/projects"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ssh completion
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r $HOME/.ssh/config ]] && _ssh_config+=($(cat $HOME/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config

# Git credentials
GIT_AUTHOR_NAME="Luke Karrys"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="luke@lukekarrys.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Set name of the theme to load.
# Look in $HOME/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="lukekarrys"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git2 z projects history history-substring-search zsh-autosuggestions)

# Brew prefix is slow on startup so just hardcode it
local CORE_UTILS_PATH="/usr/local/opt/coreutils"

# For brew install coreutils and other path stuff
export PATH="$HOME/.dotfiles-bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/opt/python@2/libexec/bin:/usr/local/bin:$CORE_UTILS_PATH/libexec/gnubin:/usr/local/sbin:$PATH"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Appends every command to the history file once it is executed
setopt inc_append_history

HIST_STAMPS="yyyy-mm-dd"

# Node
ulimit -n 10000

# dont show % sign when ctrl-c'ing
export PROMPT_EOL_MARK=""

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles
for file in $HOME/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

eval "$(starship init zsh)"