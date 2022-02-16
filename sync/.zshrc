ZSH_DISABLE_COMPFIX="true"

export DEFAULT_USER="lukekarrys"
export DEFAULT_GH_ORG="lukekarrys"
export PROJECTS_DIR="$HOME/projects"
export PROJECTS_REMOTE="org:npm topic:npm-cli,org:bracketclub,org:lukekarrys"
export DOTFILES_DIR="$PROJECTS_DIR/lukekarrys/dotfiles"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ssh completion
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r $HOME/.ssh/config ]] && _ssh_config+=($(cat $HOME/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config

# Git credentials
export GIT_AUTHOR_NAME="Luke Karrys"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
export GIT_AUTHOR_EMAIL="luke@lukekarrys.com"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Set name of the theme to load.
# Look in $HOME/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="lukekarrys"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# ================================
# zsh auto suggestion stuff
# ================================
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(npm git git2 projects history history-substring-search zsh-autosuggestions)
# disabled plugins=(z)

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

# install volta
export VOLTA_HOME="$HOME/.volta"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/opt/python@3.9/libexec/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"
PATH="`gem environment gemdir`/bin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="$VOLTA_HOME/bin:$PATH"
PATH="$HOME/.dotfiles-bin:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH="$PATH"

eval "$(starship init zsh)"
