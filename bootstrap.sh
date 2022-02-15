#!/usr/bin/env zsh

function title() {
  echo ""
  echo "================================"
  echo "  $1"
  echo "================================"
}

title "rsync all files except git, npm"
rsync -ahv --exclude ".DS_Store" sync/.* ~

title "rsync git files individually"
for file in sync/git*(.); do
  echo "- file: $file"
  rsync -ahv --no-R --no-implied-dirs $file "$HOME/.$(basename -- $file)"
  echo ""
done

title "set global npm configs"
IFS=$'\n'
for i in $(cat < sync/npmrc); do
  echo "- npm: $i"
  npm config set "$i"
done

title "all done!"