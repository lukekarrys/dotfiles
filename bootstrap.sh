#!/usr/bin/env zsh

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "*.md" --exclude "*.txt" --exclude "_config/" \
        --exclude "oh-my-zsh" -avh --no-perms . ~;
    source ~/.zshrc;