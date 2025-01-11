## functions
```
# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git --no-pager diff --no-index --color "$@" | diff-so-fancy;
	}
fi;

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function node_repl() {
	fnm install "$1" 2> /dev/null && fnm exec --using="$1" node
}

function npm_manifest() {
	curl -s https://registry.npmjs.org/$1
}

function npm_corgi() {
	curl -s --header "Accept: application/vnd.npm.install-v1+json" https://registry.npmjs.org/$1
}
```

# fzf-tab
```
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd or eza
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath; [ -f "$realpath" ] && bat -r :10 --style numbers $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --color=always $realpath; [ -f "$realpath" ] && bat -r :10 --style numbers $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'eza -1 --color=always $realpath; [ -f "$realpath" ] && bat -r :10 --style numbers $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
```

## projects

```
function trep() {
  if [ -z "$1" ]; then
    tree -aCd -L 2 $PROJECTS_DIR
  else
    tree -aCd -L 1 $PROJECTS_DIR/$1
  fi
}
```

## mygit

```
alias gco='git checkout'
alias gdw='git diff --word-diff'

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

# These are personal git aliases that arent supplied by oh-my-zsh or override ones supplied by the plugin
alias gs='git status -s'
alias gss='git status -s'
#alias gdf='git diff-index --quiet HEAD -- || clear; git --no-pager diff --color --patch-with-stat | diff-so-fancy'
alias gca='git add -A && git commit -avm'
alias gc='git commit -vm'
alias gaa='git add -A && git commit --amend --reuse-message=HEAD'
alias gpu='git remote prune origin'

function gdf () {
  git --no-pager diff --color --patch-with-stat "$@" | diff-so-fancy
}
compdef _git gdf=git-diff

alias gpo='git push origin'
compdef _git ggp=git-checkout

alias gpob='git push origin $(git_current_branch)'
compdef _git ggp=git-checkout

function gl () {
  git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit "$@"
}

alias gl5='gl -n 5'

function glb () {
  local branch=$1
  shift
  gl "$@ HEAD..$branch"
}

# Remove branches that have already been merged with master
# a.k.a. ‘delete merged’
alias gdm='git branch --merged | grep -v "\\*" | xargs -n 1 git branch -d'

# delete all branches without a remote
# this forces the delete with -D for unmerged branches
function gdo() { git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done }

# Switch to a branch, creating it if necessary
function ggo() { git checkout -b "$1" 2> /dev/null || git checkout "$1"; }

# Find branches containing commit
function gfb () { git branch -a --contains $1; }

# Find tags containing commit
function gft () { git describe --always --contains $1; }

# Find commits by source code
function gfc () { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }

# Find commits by commit message
function gfm () { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }

# Interactive rebase with the given number of latest commits
function greb () {
  if [[ ${#1} -ge 7 ]] ; then
    git rebase -i $1~1;
  else
    git rebase -i HEAD~$1;
  fi
}

# git-log-grep and get sha for first matching commit
function glg () { git log --all -n 1 --grep="$1" | grep commit | sed 's/commit //' | tr -d '\n' }

# set upstream for remote to current branch
function gso() { git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD` `git symbolic-ref --short HEAD` }
function gsup() { gso }
function gsu() { gso }

alias gugh='git add . && git commit --amend --no-edit'
```