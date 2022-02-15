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
      echo "Could not find $PROJECT_DIR/$1"
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
    ORG=$DEFAULT_GH_ORG
    REPO=$QUERY
  fi

  if [ -d "$PROJECT_DIR/$ORG/$REPO" ]; then
    cd $PROJECT_DIR/$ORG/$REPO
    gh repo sync
  else
    mkd $PROJECT_DIR/$ORG
    gh repo clone $ORG/$REPO
    cd $REPO
  fi
}

function trep() {
  if [ -z "$1" ]; then
    tree -aCd -L 2 $PROJECT_DIR
  else
    tree -aCd -L 1 $PROJECT_DIR/$1
  fi
}

# completion
ORGS=()
REPOS=()
ALL_PROJECTS=()
for org in $PROJECT_DIR/*; do
  ORGS+=("$(basename -- $org)")
  for repo in $org/*; do
    REPOS+=("$(basename -- $repo)")
  done
done

while read repo; do
  REPOS+=("$repo")
done <$ZSH/custom/plugins/projects/data.txt

ALL_PROJECTS+=($(echo "("${REPOS[@]}" "${ORGS[@]}")" | tr ' ' '\n' | sort -u))

zstyle ':completion:p' $ALL_PROJECTS
zstyle ':completion:clone' $ALL_PROJECTS
zstyle ':completion:trep' $ORGS
