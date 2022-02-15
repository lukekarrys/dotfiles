function p() {
  if [ -z "$1" ]; then
    cd $PROJECT_DIR
  else
    # last match will be a repo if it exists, otherwise the org
    # allows for going straight to repo with same name as org
    repo_match=$(find $PROJECT_DIR -maxdepth 2 -type d | grep "/$1$" | tail -n1)
    if [ -d "$repo_match" ]; then
      cd $repo_match
    elif [ -d "$PROJECT_DIR/$1" ]; then
      cd $PROJECT_DIR/$1
    else
      echo "Could not find $1"
      exit 1
    fi
  fi
}

function clone() {
  if [ -z "$1" ]; then
    echo "Needs org and repo args"
    exit 1
  fi
  p
  mkd $1
  if [ -d "$2" ]; then
    cd $2
    git pull
  else
    gh repo clone $1/$2
    cd $2
  fi
}

function trep() {
  if [ -z "$1" ]; then
    tree -aCd -L 2 $PROJECT_DIR
  else
    tree -aCd -L 1 $PROJECT_DIR/$1
  fi
}

ORGS="" # orgs are only autocompleted on disk
LOCAL_REPOS=""
REMOTE_REPOS=$(grep -Ev '^#' $PROJECT_DIR/lukekarrys/dotfiles/data/gh-repos.txt | tr "\n" " ")
for org in $PROJECT_DIR/*; do
  ORGS="$ORGS $(basename -- $org)"
  for repo in $org/*; do
    LOCAL_REPOS="$LOCAL_REPOS $(basename -- $repo)"
  done
done

compctl -k "($(echo "$ORGS $LOCAL_REPOS $REMOTE_REPOS" | tr "\n" " "))" p clone
compctl -k "($ORGS)" trep
