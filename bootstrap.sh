#!/usr/bin/env zsh

npm ls -g --depth=0 > installed-packages/npm.text
brew ls > installed-packages/brew.txt
cat ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings | jq .installed_packages > installed-packages/sublime.txt

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "*.md" --exclude "*.txt" --exclude "itermcolors/" \
        --exclude "oh-my-zsh/" --exclude "installed-packages/" --exclude "Sublime Text 3/" \
        -avh --no-perms . ~;
    source ~/.zshrc;

rsync -avh --no-perms ./Sublime\ Text\ 3/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/