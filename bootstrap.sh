#!/usr/bin/env zsh

DUMP=$1

function npm-ls-global() {
  local MODULES=$(volta list -c --format plain |grep "package " | sed -e 's/package //' | cut -d "/" -f1)
  echo $MODULES
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
