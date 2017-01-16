#!/usr/bin/env zsh

DUMP=$1
MACOS_VERSION=$(sw_vers -productVersion)

if [[ "$DUMP" == "--dump" ]] then
  echo "Dumping npm and brew"
  npm ls -g --depth=0 --parseable | tail -n +2 | xargs -n1 basename > installed-packages/npm.txt
  brew bundle dump --file=installed-packages/Brewfile --force
fi

rsync --exclude ".git/" \
      --exclude ".DS_Store" \
      --exclude "bootstrap.sh" \
      --exclude "*.md" \
      --exclude "*.txt" \
      --exclude "itermcolors/" \
      --exclude "oh-my-zsh/" \
      --exclude "installed-packages/" \
      -avh --no-perms . ~;

# Super hack. UseKeychain only works in 10.12.x
# TODO: Needs to be updated for other versions obviously.
if [[ "$MACOS_VERSION" == "10.12."* ]] then
  sed -i -- 's/# UseKeychain/UseKeychain/g' ~/.ssh/config
fi

source ~/.zprofile;
source ~/.zshrc;
