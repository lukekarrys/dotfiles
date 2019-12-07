export DEFAULT_USER="lukekarrys"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

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
ZSH_CUSTOM=~/projects/lukekarrys/dotfiles/oh-my-zsh

# dont use color for history substring search
export DISABLE_COLOR="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git2 sublime rsync github battery z projects history history-substring-search)

# slow, disabled plugins
# npm

# Brew prefix is slow on startup so just hardcode it
local CORE_UTILS_PATH="/usr/local/opt/coreutils"

# For brew install coreutils and other path stuff
export PATH="$HOME/.dotfiles-bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/opt/python@2/libexec/bin:/usr/local/bin:$CORE_UTILS_PATH/libexec/gnubin:/usr/local/sbin:$PATH"
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
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lukekarrys/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lukekarrys/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/lukekarrys/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lukekarrys/google-cloud-sdk/completion.zsh.inc'; fi