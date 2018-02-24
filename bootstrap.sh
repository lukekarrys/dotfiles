#!/usr/bin/env zsh

DUMP=$1

function npm-ls-global() {
  local MODULES=$(npm ls -g --depth=0 --parseable | tail -n +2)
  while IFS= read -r MODULE; do
    local DIR=$(dirname $MODULE | xargs -n1 basename)
    local BASE=$(basename $MODULE)
    local INSTALLED_MODULE=''
    if [ "$DIR" != "node_modules" ]; then
      INSTALLED_MODULE="$DIR/$BASE"
    else
      INSTALLED_MODULE="$BASE"
    fi
    echo $INSTALLED_MODULE;
  done <<< "$MODULES"
}

if [[ "$DUMP" == "--dump" ]] then
  echo "Dumping npm and brew"
  npm-ls-global 2> /dev/null > installed-packages/npm.txt
  brew bundle dump --file=installed-packages/Brewfile --force
fi

rsync --exclude ".git/" \
      --exclude ".gitignore" \
      --exclude ".DS_Store" \
      --exclude "bootstrap.sh" \
      --exclude "*.md" \
      --exclude "*.txt" \
      --exclude "itermcolors/" \
      --exclude "oh-my-zsh/" \
      --exclude "installed-packages/" \
      -avh --no-perms . ~;

mv ~/.gitignore-dotfiles ~/.gitignore

source ~/.zprofile;
source ~/.zshrc;
