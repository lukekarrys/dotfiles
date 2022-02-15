#!/usr/bin/env zsh

DUMP=$1

function npm-ls-global() {
  local MODULES=$(volta list -c --format plain | grep "package " | sed -e 's/package //' | cut -d "/" -f1)
  echo $MODULES
}

function title() {
  echo ""
  echo "================================"
  echo "  $1"
  echo "================================"
}

if [[ "$DUMP" == "--dump" ]] then
  title "Dumping npm and brew"
  npm-ls-global 2> /dev/null > bootstrap/npm.txt
  brew bundle dump --file=bootstrap/Brewfile --force
fi

title "rsync all files except git, npm"
rsync --exclude "_old/" \
      --exclude ".git*" \
      --exclude "git*" \
      --exclude "npm*" \
      --exclude ".DS_Store" \
      --exclude "bootstrap*" \
      --exclude "*.md" \
      --exclude "*.txt" \
      -ahv . ~;

title "rsync git files individually"
for file in git*(.); do
  rsync -ahv --no-R --no-implied-dirs $file "$HOME/.$file"
done

title "set global npm configs"
IFS=$'\n'
for i in $(cat < "npmrc"); do
  npm config set "$i"
done

title "all done!"