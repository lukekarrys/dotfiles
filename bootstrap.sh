#!/usr/bin/env zsh

npm ls -g --depth=0 --parseable | xargs -n1 basename > installed-packages/npm.txt
brew bundle dump --file=installed-packages/Brewfile
cat ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings | json installed_packages > installed-packages/sublime.txt

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "*.md" --exclude "*.txt" --exclude "itermcolors/" \
        --exclude "oh-my-zsh/" --exclude "installed-packages/" --exclude "Sublime Text 3/" \
        -avh --no-perms . ~;

source ~/.zprofile;
source ~/.zshrc;

rsync -avh --no-perms ./Sublime\ Text\ 3/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/