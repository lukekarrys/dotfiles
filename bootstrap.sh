#!/usr/bin/env zsh

npm ls -g --depth=0 --parseable | tail -n +2 | xargs -n1 basename > installed-packages/npm.txt
brew bundle dump --file=installed-packages/Brewfile --force

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "*.md" --exclude "*.txt" --exclude "itermcolors/" \
        --exclude "oh-my-zsh/" --exclude "installed-packages/" \
        -avh --no-perms . ~;

source ~/.zprofile;
source ~/.zshrc;
