#!/usr/bin/env zsh

DATA_DIR=data
PUSH="${1:--push}"

function npm-ls-global() {
  local MODULES=$(volta list -c --format plain | grep "package " | sed -e 's/package //' | cut -d " " -f1)
  echo $MODULES
}

function title() {
  echo ""
  echo "==================================================================="
  echo "  $1"
  echo "==================================================================="
}

title "Saving list of global npm packages"
npm-ls-global 2> /dev/null > $DATA_DIR/npm.txt

title "Saving list of installed homebrew packages"
brew bundle dump --file=$DATA_DIR/Brewfile --force

title "Saving list of autocomplete gh repos"
> $DATA_DIR/gh-repos.txt
gh ls-repos-name "org:npm topic:npm-cli" >> $DATA_DIR/gh-repos.txt

title "Committing changes"
git add data/
git commit -m "Saving data"

# if [[ $PUSH == "--push "]]; then
#   git push
# fi
