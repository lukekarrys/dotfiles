# These are personal git aliases that arent supplied by oh-my-zsh or override ones supplied by the plugin
alias gl='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --'
alias gs='git status -s'
alias gss='git status -s'
alias gdf='git diff-index --quiet HEAD -- || clear; git --no-pager diff --color --patch-with-stat | diff-so-fancy'
alias gca='git add -A && git commit -avm'
alias gc='git commit -vm'
alias gaa='git add -A && git commit --amend --reuse-message=HEAD'
alias gpu='git remote prune origin'

alias gpo='git push origin'
compdef gpo=git
alias gpob='git push origin $(current_branch)'
compdef gpo=git

# Remove branches that have already been merged with master
# a.k.a. ‘delete merged’
alias gdm='git branch --merged | grep -v "\\*" | xargs -n 1 git branch -d'

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
function greb () { git rebase -i HEAD~$1; }
