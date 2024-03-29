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