export DEFAULT_USER="lukekarrys"

# Path to your oh-my-zsh installation.
export ZSH=/Users/lukekarrys/.oh-my-zsh

# ssh completion
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config

# Git credentials
GIT_AUTHOR_NAME="Luke Karrys"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="lukekarrys@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="lukekarrys"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=/Users/lukekarrys/projects/lukekarrys/dotfiles/oh-my-zsh

# dont use color for history substring search
export DISABLE_COLOR="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node sublime rsync history github emoji-clock brew battery z projects git2 history-substring-search)

# slow, disabled plugins
# npm

# For brew install coreutils and other path stuff
export PATH="$HOME/bin:/Applications/Postgres.app/Contents/Versions/9.5/bin:/usr/local/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH:$HOME/.rvm/bin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# Node
ulimit -n 10000

# dont show % sign when ctrl-c'ing
export PROMPT_EOL_MARK=""

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles
for file in ~/.{exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
