
## aliases
```
# Shortcuts
alias dl="cd {{ .homeDir }}/Downloads"
alias dt="cd {{ .homeDir }}/Desktop"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# ls colors
export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# List all files colorized in long format
alias l="eza -lF --no-user --color=always"

# List all files colorized in long format, including dot files
alias la="eza -laF --no-user --color=always"

# List only directories
alias lsd="eza -lFD --no-user --color=always"

# Always use color output for ls
alias ls="command ls --color"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Dock
alias dock-spacer="defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type=\"spacer-tile\";}' && killall Dock"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv {{ .homeDir }}/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Merge PDF files
# Usage: 'mergepdf -o output.pdf input{1,2,3}.pdf'
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

alias dateslug='date "+%Y-%m-%d %H:%M"'
alias dateiso='date -u +"%Y-%m-%dT%H:%M:%S.%NZ"'

# bootstrap and source
alias dotedit="chezmoi edit"

alias beep="node -e 'process.stdout.write(\"\x07\")'"

alias nodemodulessize="find $PROJECTS_DIR -type d -name 'node_modules' -maxdepth 3 | xargs du -ch --max-depth=0"
alias nodemoduleslist="find $PROJECTS_DIR -type d -name 'node_modules' -maxdepth 3 -exec echo {} \;"
alias nodemodulesdelete="find $PROJECTS_DIR -type d -name 'node_modules' -maxdepth 3 -exec rm -rf {} \;"

alias cleancaches="brew cleanup"

alias ghwd='gh wd'
alias ghpr='gh prvw'

alias cz='chezmoi'

# alias cat="bat"

alias vlt_local="/Users/lukekarrys/projects/vltpkg/vltpkg/node_modules/.bin/vlt"
```

## functions
```
# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$@";
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
	function diff() {
		git --no-pager diff --no-index --color "$@" | diff-so-fancy;
	}
fi;

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
	if [ $# -eq 0 ]; then
		code .;
	else
		code "$@";
	fi;
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
	if [ $# -eq 0 ]; then
		vim .;
	else
		vim "$@";
	fi;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function findprocess() {
    ps -x | grep "ttys" | grep "$@" | grep -v "grep"
}

function rungist() {
    curl -s $@ | node
}

function findport() {
    sudo lsof -n -i4TCP:$@ | grep LISTEN
}

function gitignore() {
  curl -s https://raw.githubusercontent.com/github/gitignore/master/$1.gitignore
}

function license() {
  curl -s https://raw.githubusercontent.com/github/choosealicense.com/gh-pages/_licenses/$1.txt | sed '1,/---/d' | tail -n +2 | head -n -1 | sed "s/\[fullname\]/$GIT_AUTHOR_NAME/" | sed "s/\[year\]/`date +%Y`/"
}

function transcode-queue() {
  ssh $@ "ps -x | grep \[t\]ranscode-video | sed 's/\(.*\)originals\/\(.*\).mkv/\2 -- inprogress/'; cat /Volumes/Data/makemkv/queue"
}

function pc() {
  prettier $@ $(git diff --name-only; ; git ls-files --others --exclude-standard)
}

function npmg() {
	(
		export PATH={{ .npmBins.pathPrefix }}$PATH;
		{{ .npmBins.command }} $@;
		if [[ "$1" == "install" ]]; then
			{{ .npmBins.command }} run postinstall;
			jq --argjson deps "$(jq '.dependencies | tojson' {{ joinPath .npmBins.dir "package.json" }})" '.dependencies = ($deps | fromjson)' {{ joinPath .chezmoi.sourceDir  "dot_npm-bins/package.json.tmpl" }} > {{ joinPath .chezmoi.sourceDir  "dot_npm-bins/package.json.new" }}
			mv {{ joinPath .chezmoi.sourceDir  "dot_npm-bins/package.json.new" }} {{ joinPath .chezmoi.sourceDir  "dot_npm-bins/package.json.tmpl" }}
		fi
	)
}

function brewcleanup() {
	brew bundle cleanup --force --file={{ .chezmoi.sourceDir }}/Brewfile
}

function brewdump() {
	brew bundle dump --force --file={{ .chezmoi.sourceDir }}/Brewfile
}

function brewg() {
	brew bundle $@ --file={{ .chezmoi.sourceDir }}/Brewfile
}

function ncug() {
	{{ .npmBinsBin }}/ncu --packageFile {{ .npmBins.dir }}/package.json $@
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

## transcode
```
export TRANSCODE_BATCH_DATA_DIR="/Users/lukekarrys/Library/Mobile Documents/com~apple~CloudDocs/Transcoding"
export TRANSCODE_BATCH_FILE_DIR="/Volumes/T7/Transcoding"
```

## projects

```
function p() {
  if [ -z "$1" ]; then
    cd $PROJECTS_DIR
  else
    # last match will be a repo if it exists, otherwise the org
    # allows for going straight to repo with same name as org
    repo_match=$(find $PROJECTS_DIR -maxdepth 2 -type d | grep "/$1$" | tail -n1)
    if [ -d "$repo_match" ]; then
      cd $repo_match
    elif [ -d "$PROJECTS_DIR/$1" ]; then
      cd $PROJECTS_DIR/$1
    else
      echo "Could not find $PROJECTS_DIR/$1"
      return 1
    fi
  fi
}

function clone() {
  if [ -z "$1" ]; then
    echo "Needs at least one arg"
    return 1
  fi

  local ORG=""
  local REPO=""
  local SPLIT="/"
  local QUERY=""

  if [ "$#" -gt 1 ]; then
    QUERY="$1/$2"
  else
    QUERY="$1"
  fi

  if test "${QUERY#*$SPLIT}" != "$QUERY"; then
    # contains a slash
    ORG="${QUERY%$SPLIT*}"
    REPO="${QUERY#*$SPLIT}"
  else
    # no slash
    ORG="{{ .githubOrg }}"
    REPO=$QUERY
  fi

  if [ -d "$PROJECTS_DIR/$ORG/$REPO" ]; then
    cd $PROJECTS_DIR/$ORG/$REPO
    gh repo sync
  else
    mkd $PROJECTS_DIR/$ORG
    gh repo clone $ORG/$REPO
    cd $REPO
  fi
}

function trep() {
  if [ -z "$1" ]; then
    tree -aCd -L 2 $PROJECTS_DIR
  else
    tree -aCd -L 1 $PROJECTS_DIR/$1
  fi
}

# completion
ORGS=()
REPOS=()
if [ -d "$PROJECTS_DIR" ]; then
  if [ "$(ls -A $PROJECTS_DIR)" ]; then
    for org in $PROJECTS_DIR/*; do
      ORGS+=("$(basename -- $org)")
      if [ -d "$org" ]; then
        if [ "$(ls -A $org)" ]; then
          for repo in $org/*; do
            REPOS+=("$(basename -- $repo)")
          done
        fi
      fi
    done
  fi
fi

while read repo; do
  REPOS+=("$repo")
done <$ZSH-custom/plugins/projects/data.txt

ALL_PROJECTS="$(echo "${REPOS[@]}" "${ORGS[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"

# TODO: better autocomplete for this based on default gh org and specific command
# eg clone can take 1 or 2 args, p can take one
compctl -k "($ALL_PROJECTS)" p clone
compctl -k "($ORGS)" trep
```

## mygit

```
# oh my zsh git plugin

# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

#
# Functions
#

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

#
# Aliases
# (sorted alphabetically)
#

alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'

function gccd() {
  command git clone --recurse-submodules "$@"
  [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}
compdef _git gccd=git-clone

function git-checkout-alias-main() {
  if [ "$1" = "main" ] || [ "$1" = "master" ] || [ "$1" = "latest" ]; then
    if [ `git rev-parse --verify main 2>/dev/null` ]; then
      git checkout main;
    elif [ `git rev-parse --verify master 2>/dev/null` ]; then
      git checkout master;
    elif [ `git rev-parse --verify latest 2>/dev/null` ]; then
      git checkout latest;
    fi
	else
	  git checkout $@;
	fi
}
compdef _git git-checkout-alias-main=git-checkout

alias gcl='git clone --recurse-submodules'
alias gclean='git clean -id'
alias gpristine='git reset --hard && git clean -dffx'
alias gcm='git-checkout-alias-main main'
alias gcd='git checkout $(git_develop_branch)'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gcss='git commit -S -s'
alias gcssm='git commit -S -s -m'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gf='git fetch'
# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
  && alias gfa='git fetch --all --prune --jobs=10' \
  || alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gfg='git ls-files | grep'

alias gg='git gui citool'
alias gga='git gui citool --amend'

function ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout
function ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggfl=git-checkout

function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
compdef _git ggl=git-checkout

function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}
compdef _git ggp=git-checkout

function ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

function ggu() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout

alias ggpur='ggu'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'

# alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
# alias gpsup='git push --set-upstream origin $(git_current_branch)'

alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(c):svntrunk'

alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log -g --pretty=%h) &!'

# alias gl='git pull'
# alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gm='git merge'
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'

# use the default stash push on git 2.13 and newer
is-at-least 2.13 "$git_version" \
  && alias gsta='git stash push' \
  || alias gsta='git stash save'

alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gstall='git stash --all'
# alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'

alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias glum='git pull upstream $(git_main_branch)'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'

alias gam='git am'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gama='git am --abort'
alias gamscp='git am --show-current-patch'

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

unset git_version

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

function gm2m {
  git branch -m master main
  git fetch origin
  git branch -u origin/main main
  git remote set-head origin -a
}

alias gugh='git add . && git commit --amend --no-edit'
```